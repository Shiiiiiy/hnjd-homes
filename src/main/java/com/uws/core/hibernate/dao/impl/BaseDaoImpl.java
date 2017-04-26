package com.uws.core.hibernate.dao.impl;

import com.uws.core.base.BaseModel;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.core.util.SystemPropertiesUtil;
import com.uws.license.client.ILicenseClient;
import com.uws.license.client.impl.LicenseClientImpl;
import com.uws.license.util.NetUtil;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.commons.beanutils.PropertyUtils;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.ScrollMode;
import org.hibernate.ScrollableResults;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.metadata.ClassMetadata;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.util.ReflectionUtils;

public class BaseDaoImpl {

	@Autowired
	protected SessionFactory sessionFactory;
	private static Properties licenceProperties = loadLicenceProperties();

	public static Properties loadLicenceProperties() {
		Properties props = null;
		// try {
		// ILicenseClient lc = new LicenseClientImpl();
		// props = SystemPropertiesUtil.getLicenseProperties();
		// if (!lc.licenseValid(props))
		// {
		// throw new Exception();
		// }
		// } catch (Exception e) {
		// try {
		// String machineCode = NetUtil.getBase64localMacAddress();
		// System.out.println("请联系系统管理员,按回车键退出：" + machineCode);
		// BufferedReader br = new BufferedReader(new
		// InputStreamReader(System.in));
		// br.readLine();
		// System.exit(0);
		// } catch (Exception ex) {
		// System.out.println("请联系系统管理员.");
		// System.exit(0);
		// }
		// }

		return props;
	}

	private Session getSession() {
		return this.sessionFactory.getCurrentSession();
	}

	public BaseModel get(Class entityClass, Serializable id) {
		return (BaseModel) getSession().get(entityClass, id);
	}

	public List query(String hql, Object[] values) {
		return createQuery(hql, values).list();
	}

	public Object queryUnique(String hql, Object[] values) {
		return createQuery(hql, values).uniqueResult();
	}

	private Query createQuery(String queryString, Object[] values) {
		Assert.hasText(queryString);
		Query queryObject = getSession().createQuery(queryString);
		if (values != null) {
			for (int i = 0; i < values.length; i++) {
				queryObject.setParameter(i, values[i]);
			}
		}
		return queryObject;
	}

	public void update(BaseModel o) {
		o.setUpdateTime(new Date());
		getSession().update(o);
	}

	public void save(BaseModel o) {
		o.setCreateTime(new Date());
		o.setUpdateTime(new Date());
		getSession().save(o);
	}

	public void delete(BaseModel o) {
		getSession().delete(o);
	}

	public void flush() {
		getSession().flush();
	}

	public void clear() {
		getSession().clear();
	}

	public void evit(BaseModel entity) {
		getSession().evict(entity);
	}

	private <T> Criteria createCriteria(Class<T> entityClass,
			Criterion[] criterions) {
		Criteria criteria = getSession().createCriteria(entityClass);
		for (Criterion c : criterions) {
			criteria.add(c);
		}
		return criteria;
	}

	private <T> Criteria createCriteria(Class<T> entityClass, String orderBy,
			boolean isAsc, Criterion[] criterions) {
		Assert.hasText(orderBy);

		Criteria criteria = createCriteria(entityClass, criterions);

		if (isAsc)
			criteria.addOrder(Order.asc(orderBy));
		else {
			criteria.addOrder(Order.desc(orderBy));
		}
		return criteria;
	}

	private Integer getCount(Class entityClass, Criterion[] criterions) {
		Criteria criteria = createCriteria(entityClass, criterions);
		Assert.notNull(criteria);
		return (Integer) criteria.setProjection(Projections.rowCount())
				.uniqueResult();
	}

	public long queryCount(String hql, Object[] values) {
		Query queryObject = createQuery(hql, values);
		List list = queryObject.list();
		if ((list != null) && (list.size() > 0)) {
			Long count = (Long) list.get(0);
			if (count.intValue() > 0) {
				return count.intValue();
			}
			return 0L;
		}

		return 0L;
	}

	public Page pagedQuery(String hql, int pageNo, int pageSize, Object[] values) {
		Assert.hasText(hql);
		Assert.isTrue(pageNo >= 1, "pageNo should start from 1");

		String countQueryString = getCountQueryString(hql);
		List countlist = query(countQueryString, values);
		long totalCount = ((Long) countlist.get(0)).longValue();

		if (totalCount < 1L) {
			return new Page();
		}

		int startIndex = Page.getStartOfPage(pageNo, pageSize);
		Query query = createQuery(hql, values);
		List list = query.setFirstResult(startIndex).setMaxResults(pageSize)
				.list();

		return new Page(startIndex, totalCount, pageSize, list);
	}

	public Serializable getId(Class entityClass, BaseModel entity)
			throws NoSuchMethodException, IllegalAccessException,
			InvocationTargetException {
		Assert.notNull(entity);
		Assert.notNull(entityClass);
		return (Serializable) PropertyUtils.getProperty(entity,
				getIdName(entityClass));
	}

	public String getIdName(Class clazz) {
		Assert.notNull(clazz);
		ClassMetadata meta = this.sessionFactory.getClassMetadata(clazz);
		Assert.notNull(meta, "Class " + clazz
				+ " not define in hibernate session factory.");
		String idName = meta.getIdentifierPropertyName();
		Assert.hasText(idName, clazz.getSimpleName()
				+ " has no identifier property define.");
		return idName;
	}

	@Deprecated
	public Page pagedSQLQuery(String sql, int pageNo, int pageSize,
			Object[] params) {
		SQLQuery query = getSession().createSQLQuery(sql);
		if (params != null) {
			for (int i = 0; i < params.length; i++) {
				query.setParameter(i, params[i]);
			}
		}
		ScrollableResults scrollableResults = query
				.scroll(ScrollMode.SCROLL_SENSITIVE);
		scrollableResults.last();
		int totalCount = scrollableResults.getRowNumber();

		return getPageResult(query, totalCount + 1, pageNo, pageSize);
	}

	public List querySQL(String sql, Object[] params) {
		SQLQuery query = getSession().createSQLQuery(sql);

		if (params != null) {
			for (int i = 0; i < params.length; i++) {
				query.setParameter(i, params[i]);
			}
		}
		return query.list();
	}

	private static String getCountQueryString(String hql) {
		int beginPos = hql.toLowerCase().indexOf(" from ");
		if (hql.toLowerCase().startsWith("from "))
			beginPos = 0;
		Assert.isTrue(beginPos != -1, " hql : " + hql
				+ " must has a keyword 'from'");
		if ((beginPos > 0)
				&& (hql.toLowerCase().substring(0, beginPos)
						.indexOf(" distinct ") > -1)) {
			return removeOrders(hql.substring(0, beginPos).replace("select",
					"select count(")
					+ ") " + hql.substring(beginPos));
		}

		return " select count (*) " + removeOrders(hql.substring(beginPos));
	}

	private static String removeOrders(String hql) {
		Assert.hasText(hql);
		Pattern p = Pattern.compile("order\\s*by[\\w|\\W|\\s|\\S]*", 2);
		Matcher m = p.matcher(hql);
		StringBuffer sb = new StringBuffer();
		while (m.find()) {
			m.appendReplacement(sb, "");
		}
		m.appendTail(sb);
		return sb.toString();
	}

	private Page getPageResult(Query query, int totalCount, int pageNo,
			int pageSize) {
		if (totalCount < 1) {
			return new Page();
		}

		int startIndex = Page.getStartOfPage(pageNo, pageSize);
		List list = query.setFirstResult(startIndex).setMaxResults(pageSize)
				.list();

		return new Page(startIndex, totalCount, pageSize, list);
	}

	public void deleteById(Class entityClass, Serializable id) {
		delete(get(entityClass, id));
	}

	public boolean isUnique(Class entityClass, BaseModel entity, String[] names) {
		Assert.noNullElements(names);
		Criteria criteria = createCriteria(entityClass, new Criterion[0])
				.setProjection(Projections.rowCount());
		try {
			for (String name : names) {
				criteria.add(Restrictions.eq(name,
						PropertyUtils.getProperty(entity, name)));
			}

			String idName = getIdName(entityClass);

			Serializable id = getId(entityClass, entity);

			if ((id != null) && (!id.equals("")))
				criteria.add(Restrictions.not(Restrictions.eq(idName, id)));
		} catch (Exception e) {
			ReflectionUtils.handleReflectionException(e);
		}
		return Integer.valueOf(criteria.uniqueResult().toString()).intValue() == 0;
	}

	private Query setParameter(Query query, Map<String, Object> map) {
		if (map != null) {
			Set<String> keySet = map.keySet();
			for (String string : keySet) {
				Object obj = map.get(string);

				if ((obj instanceof Collection))
					query.setParameterList(string, (Collection) obj);
				else if ((obj instanceof Object[]))
					query.setParameterList(string, (Object[]) obj);
				else {
					query.setParameter(string, obj);
				}
			}
		}
		return query;
	}

	public Page pagedQuery(String hql, Map<String, Object> map, int pageSize,
			int pageNo) {
		Assert.hasText(hql);
		Assert.isTrue(pageNo >= 1, "pageNo should start from 1");

		String countQueryString = getCountQueryString(hql);
		List countlist = getQuery(countQueryString, map).list();
		long totalCount = ((Long) countlist.get(0)).longValue();
		if (totalCount < 1L) {
			return new Page();
		}

		int startIndex = Page.getStartOfPage(pageNo, pageSize);
		Query query = getQuery(hql, map, pageSize, pageNo);
		List list = getQuery(hql, map, pageSize, pageNo).list();

		return new Page(startIndex, totalCount, pageSize, list);
	}

	public void executeHql(String hql, Object[] values) {
		Query queryObject = createQuery(hql, values);
		queryObject.executeUpdate();
	}

	public void executeHql(String hql, Map<String, Object> map) {
		Query query = getQuery(hql, map);
		query.executeUpdate();
	}

	public List query(String hql, Map<String, Object> map) {
		return getQuery(hql, map).list();
	}

	private Query getQuery(String hql, Map<String, Object> map) {
		Query query = createQuery(hql, new Object[0]);
		query = setParameter(query, map);
		return query;
	}

	private Query getQuery(String hql, Map<String, Object> map, int pageSize,
			int pageNo) {
		Query query = createQuery(hql, new Object[0]);
		query = setParameter(query, map);
		query = setPageProperty(query, pageSize, pageNo);
		return query;
	}

	private Query setPageProperty(Query query, int pageSize, int pageNo) {
		if ((pageNo != 0) && (pageSize != 0)) {
			query.setFirstResult((pageNo - 1) * pageSize);
			query.setMaxResults(pageSize);
		}
		return query;
	}
	
	
	
}
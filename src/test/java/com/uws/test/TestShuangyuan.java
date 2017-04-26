/**
 * Created on 2017年4月19日
 * Id: TestShuangyuan.java,v 1.0 2017年4月19日 下午3:33:29 联合永道
 */
package com.uws.test;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONObject;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.junit.Test;

/**
 * @ClassName TestShuangyuan
 * @date 2017年4月19日 下午3:33:29
 * @author GuZG
 * @Description 双元微课接口测试类
 */
public class TestShuangyuan {

	private static final String CHARSET = "GBK";

	@Test
	public void testOrg() {
		HttpClient httpclient = new DefaultHttpClient();
		String baseUrl = "http://xxkj.hnjdxy.cn/dockingInitOrgan.do?action=getOrgans";
		String scKey = "17041115515991093";
		HttpPost httppost = new HttpPost(baseUrl);
		String strResult = null;

		try {

			List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();

			nameValuePairs.add(new BasicNameValuePair("scKey", scKey));
			httppost.addHeader("Content-type",
					"application/x-www-form-urlencoded");
			httppost.setEntity(new UrlEncodedFormEntity(nameValuePairs, "UTF-8"));

			HttpResponse response = httpclient.execute(httppost);
			if (response.getStatusLine().getStatusCode() == 200) {
				/* 读返回数据 */
				InputStream ins = response.getEntity().getContent();

				// 按指定的字符集构建文件流
				BufferedReader br = new BufferedReader(new InputStreamReader(
						ins, CHARSET));
				StringBuffer sbf = new StringBuffer();
				String line = null;
				while ((line = br.readLine()) != null) {
					sbf.append(line);
				}

				br.close();

				System.out.println(sbf.toString());
			} else {
				String err = response.getStatusLine().getStatusCode() + "";
				strResult += "发送失败:" + err;
				System.out.println(strResult);
			}
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private String getStringFromJson(JSONObject adata) {
		StringBuffer sb = new StringBuffer();
		sb.append("{");
		for (Object key : adata.keySet()) {
			sb.append("\"" + key + "\":\"" + adata.get(key) + "\",");
		}
		String rtn = sb.toString().substring(0, sb.toString().length() - 1)
				+ "}";
		return rtn;
	}

}

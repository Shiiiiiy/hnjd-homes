/**
 * Created on 2017年4月25日
 * Id: TaskJob.java,v 1.0 2017年4月25日 下午1:47:58 联合永道
 */
package com.uws.home.task;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * @ClassName TaskJob
 * @date 2017年4月25日 下午1:47:58
 * @author GuZG
 * @Description 定时任务调用
 */
@Component("taskJob")
public class TaskJob {
	
	private static int i=0;

	@Scheduled(cron = "${HOME_SHUANGYUAN_SYNC_ORG_TIMER}")
	public void syncOrgJob() {
		
		System.out.println("Timer job -------> "+i++);

	}

}

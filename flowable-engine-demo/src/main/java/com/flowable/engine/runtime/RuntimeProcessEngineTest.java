package com.flowable.engine.runtime;

import com.flowable.engine.deploy.FlowableDeployTest;
import org.flowable.engine.ProcessEngine;
import org.flowable.engine.ProcessEngineConfiguration;
import org.flowable.engine.RuntimeService;
import org.flowable.engine.TaskService;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.task.api.Task;
import org.junit.Test;
import org.springframework.util.CollectionUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RuntimeProcessEngineTest {

    ProcessEngineConfiguration configuration = new FlowableDeployTest().init();

    /**
     * 启动流程
     */
    @Test
    public void runtimeProcessEngine() {
        //1.流程启动类
        ProcessEngine processEngine = configuration.buildProcessEngine();
        RuntimeService runtimeService = processEngine.getRuntimeService();

        //2.流程中参数
        Map<String, Object> variables = new HashMap<>();
        variables.put("1", "1");
        variables.put("initiator", "1");

        //3.启动流程类
        ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("holidayRequest", variables);

        System.out.println("holidayRequest.ProcessDefinitionId=" + processInstance.getProcessDefinitionId());
        System.out.println("holidayRequest.ActivityId=" + processInstance.getActivityId());
        System.out.println("holidayRequest.Id=" + processInstance.getId());
    }

    @Test
    public void queryTask() {
        ProcessEngine processEngine = configuration.buildProcessEngine();
        TaskService taskService = processEngine.getTaskService();
        List<Task> holidayRequest = taskService.createTaskQuery()
                .processDefinitionKey("holidayRequest")
                .list();
        if(!CollectionUtils.isEmpty(holidayRequest)){
            holidayRequest.forEach(task->{
                System.out.println("task.ProcessDefinitionId="+task.getProcessDefinitionId());
                System.out.println("task.Name="+task.getName());
                System.out.println("task.Assignee="+task.getAssignee());
                System.out.println("task.Description="+task.getDescription());
                System.out.println("task.FormKey="+task.getFormKey());
                System.out.println("task.Owner="+task.getOwner());
            });
        }
    }

}

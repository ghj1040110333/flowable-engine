package com.flowable.engine.deploy;

import lombok.Data;
import org.flowable.engine.ProcessEngine;
import org.flowable.engine.ProcessEngineConfiguration;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.impl.cfg.StandaloneProcessEngineConfiguration;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.DeploymentBuilder;
import org.flowable.engine.repository.ProcessDefinition;
import org.junit.Before;
import org.junit.Test;
import org.springframework.util.CollectionUtils;

import java.util.List;


@Data
public class FlowableDeployTest {

    public ProcessEngineConfiguration init() {
        getProcessEngineConfig();
        return configuration;
    }

    ProcessEngineConfiguration configuration;

    /**
     * 流程引擎配置类
     */
    @Before
    public void getProcessEngineConfig() {
        configuration = new StandaloneProcessEngineConfiguration();
        //设置数据库连接信息
        configuration.setJdbcUrl("jdbc:mysql://localhost:3306/flowable?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8");
        configuration.setJdbcDriver("com.mysql.cj.jdbc.Driver");
        configuration.setJdbcUsername("root");
        configuration.setJdbcPassword("root");
        configuration.setDatabaseSchemaUpdate(ProcessEngineConfiguration.DB_SCHEMA_UPDATE_FALSE);
    }

    /**
     * 1.部署流程
     */
    @Test
    public void deployProcessEngine() {
        //1.通过配置信息获取 ProcessEngine引擎类
        ProcessEngine processEngine = configuration.buildProcessEngine();

        //2.通过RepositoryService仓库服务类->获取部署构建类
        RepositoryService repositoryService = processEngine.getRepositoryService();
        DeploymentBuilder deployment = repositoryService.createDeployment();

        //3.部署流程
        Deployment deploy = deployment.name("部署流程") //流程名称
                .key("holidayRequest")//流程部署键值
                .addClasspathResource("process/requestHoliday.bpmn")//流程资源位置
                .deploy(); //部署流程
        System.out.println("deploy.Id=" + deploy.getId());
        System.out.println("deploy.name=" + deploy.getName());
        System.out.println("deploy.key=" + deploy.getKey());
    }


    /**
     * 根据流程实列id查询
     */
    @Test
    public void queryDeployById() {
        //获取流程定义数据
        ProcessEngine processEngine = configuration.buildProcessEngine();
        RepositoryService repositoryService = processEngine.getRepositoryService();
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                .deploymentId("2501")//查询流程id
                .singleResult();

        //数据查询
        System.out.println("定义流程ID=" + processDefinition.getDeploymentId());
        System.out.println("定义流程name=" + processDefinition.getName());
        System.out.println("定义流程version=" + processDefinition.getVersion());
    }

    /**
     * 查询流程实例列表
     */
    @Test
    public void queryDeployList() {
        ProcessEngine processEngine = configuration.buildProcessEngine();
        RepositoryService repositoryService = processEngine.getRepositoryService();
        List<ProcessDefinition> processDefinitions = repositoryService.createProcessDefinitionQuery().list();
        if (!CollectionUtils.isEmpty(processDefinitions)) {
            processDefinitions.forEach(processDefinition -> {
                //查询所有流程列表
                System.out.println("定义流程ID=" + processDefinition.getDeploymentId());
                System.out.println("定义流程name=" + processDefinition.getName());
                System.out.printf("定义流程version=%s\n\n", processDefinition.getVersion());
            });
        }
    }

    /**
     * 删除流程实例
     */
    @Test
    public void deleteDeploy() {
        ProcessEngine processEngine = configuration.buildProcessEngine();
        RepositoryService repositoryService = processEngine.getRepositoryService();
        //删除部署的流程
        //repositoryService.deleteDeployment("1");
        //删除级联删除 如果流程启动了也是删除相关的任务的
        repositoryService.deleteDeployment("27501", true);
        repositoryService.deleteDeployment("15001", true);
        repositoryService.deleteDeployment("10001", true);

    }
}

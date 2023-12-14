alter table ACT_RU_IDENTITYLINK add column SCOPE_ID_ varchar(255);
alter table ACT_RU_IDENTITYLINK add column SCOPE_TYPE_ varchar(255);
alter table ACT_RU_IDENTITYLINK add column SCOPE_DEFINITION_ID_ varchar(255);

create index ACT_IDX_IDENT_LNK_SCOPE on ACT_RU_IDENTITYLINK(SCOPE_ID_, SCOPE_TYPE_);
create index ACT_IDX_IDENT_LNK_SCOPE_DEF on ACT_RU_IDENTITYLINK(SCOPE_DEFINITION_ID_, SCOPE_TYPE_);

alter table ACT_RU_TASK add column SUB_TASK_COUNT_ integer;
update ACT_RU_TASK t set SUB_TASK_COUNT_ = (select count(*) from (select * from ACT_RU_TASK where IS_COUNT_ENABLED_ = true) as count_table where PARENT_TASK_ID_ = t.ID_) where t.IS_COUNT_ENABLED_ = true;

update ACT_RU_TIMER_JOB set HANDLER_TYPE_ = 'cmmn-trigger-timer' where HANDLER_TYPE_ = 'trigger-timer' and SCOPE_TYPE_ = 'cmmn';

update ACT_GE_PROPERTY set VALUE_ = '6.3.0.1' where NAME_ = 'identitylink.schema.version';

alter table ACT_RU_TASK add column TASK_DEF_ID_ varchar(64);

update ACT_GE_PROPERTY set VALUE_ = '6.3.0.1' where NAME_ = 'task.schema.version';

update ACT_GE_PROPERTY set VALUE_ = '6.3.0.1' where NAME_ = 'variable.schema.version';

update ACT_GE_PROPERTY set VALUE_ = '6.3.0.1' where NAME_ = 'job.schema.version';

alter table ACT_HI_IDENTITYLINK add column SCOPE_ID_ varchar(255);
alter table ACT_HI_IDENTITYLINK add column SCOPE_TYPE_ varchar(255);
alter table ACT_HI_IDENTITYLINK add column SCOPE_DEFINITION_ID_ varchar(255);

create index ACT_IDX_HI_IDENT_LNK_SCOPE on ACT_HI_IDENTITYLINK(SCOPE_ID_, SCOPE_TYPE_);
create index ACT_IDX_HI_IDENT_LNK_SCOPE_DEF on ACT_HI_IDENTITYLINK(SCOPE_DEFINITION_ID_, SCOPE_TYPE_);

alter table ACT_HI_TASKINST add column TASK_DEF_ID_ varchar(64);

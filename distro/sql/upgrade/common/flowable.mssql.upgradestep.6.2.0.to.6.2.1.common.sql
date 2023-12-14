update ACT_GE_PROPERTY set VALUE_ = '6.2.1.0' where NAME_ = 'common.schema.version';

update ACT_GE_PROPERTY set VALUE_ = '6.2.1.0' where NAME_ = 'identitylink.schema.version';

update ACT_GE_PROPERTY set VALUE_ = '6.2.1.0' where NAME_ = 'task.schema.version';

update ACT_GE_PROPERTY set VALUE_ = '6.2.1.0' where NAME_ = 'variable.schema.version';

alter table ACT_RU_JOB add SCOPE_ID_ nvarchar(255);
alter table ACT_RU_JOB add SUB_SCOPE_ID_ nvarchar(255);
alter table ACT_RU_JOB add SCOPE_TYPE_ nvarchar(255);
alter table ACT_RU_JOB add SCOPE_DEFINITION_ID_ nvarchar(255);

alter table ACT_RU_TIMER_JOB add SCOPE_ID_ nvarchar(255);
alter table ACT_RU_TIMER_JOB add SUB_SCOPE_ID_ nvarchar(255);
alter table ACT_RU_TIMER_JOB add SCOPE_TYPE_ nvarchar(255);
alter table ACT_RU_TIMER_JOB add SCOPE_DEFINITION_ID_ nvarchar(255);

alter table ACT_RU_SUSPENDED_JOB add SCOPE_ID_ nvarchar(255);
alter table ACT_RU_SUSPENDED_JOB add SUB_SCOPE_ID_ nvarchar(255);
alter table ACT_RU_SUSPENDED_JOB add SCOPE_TYPE_ nvarchar(255);
alter table ACT_RU_SUSPENDED_JOB add SCOPE_DEFINITION_ID_ nvarchar(255);

alter table ACT_RU_DEADLETTER_JOB add SCOPE_ID_ nvarchar(255);
alter table ACT_RU_DEADLETTER_JOB add SUB_SCOPE_ID_ nvarchar(255);
alter table ACT_RU_DEADLETTER_JOB add SCOPE_TYPE_ nvarchar(255);
alter table ACT_RU_DEADLETTER_JOB add SCOPE_DEFINITION_ID_ nvarchar(255);

create index ACT_IDX_JOB_SCOPE on ACT_RU_JOB(SCOPE_ID_, SCOPE_TYPE_);
create index ACT_IDX_JOB_SUB_SCOPE on ACT_RU_JOB(SUB_SCOPE_ID_, SCOPE_TYPE_);
create index ACT_IDX_JOB_SCOPE_DEF on ACT_RU_JOB(SCOPE_DEFINITION_ID_, SCOPE_TYPE_);

create index ACT_IDX_TJOB_SCOPE on ACT_RU_TIMER_JOB(SCOPE_ID_, SCOPE_TYPE_);
create index ACT_IDX_TJOB_SUB_SCOPE on ACT_RU_TIMER_JOB(SUB_SCOPE_ID_, SCOPE_TYPE_);
create index ACT_IDX_TJOB_SCOPE_DEF on ACT_RU_TIMER_JOB(SCOPE_DEFINITION_ID_, SCOPE_TYPE_); 

create index ACT_IDX_SJOB_SCOPE on ACT_RU_SUSPENDED_JOB(SCOPE_ID_, SCOPE_TYPE_);
create index ACT_IDX_SJOB_SUB_SCOPE on ACT_RU_SUSPENDED_JOB(SUB_SCOPE_ID_, SCOPE_TYPE_);
create index ACT_IDX_SJOB_SCOPE_DEF on ACT_RU_SUSPENDED_JOB(SCOPE_DEFINITION_ID_, SCOPE_TYPE_);   

create index ACT_IDX_DJOB_SCOPE on ACT_RU_DEADLETTER_JOB(SCOPE_ID_, SCOPE_TYPE_);
create index ACT_IDX_DJOB_SUB_SCOPE on ACT_RU_DEADLETTER_JOB(SUB_SCOPE_ID_, SCOPE_TYPE_);
create index ACT_IDX_DJOB_SCOPE_DEF on ACT_RU_DEADLETTER_JOB(SCOPE_DEFINITION_ID_, SCOPE_TYPE_); 

alter table ACT_RU_JOB add CUSTOM_VALUES_ID_ nvarchar(64);
alter table ACT_RU_TIMER_JOB add CUSTOM_VALUES_ID_ nvarchar(64);
alter table ACT_RU_SUSPENDED_JOB add CUSTOM_VALUES_ID_ nvarchar(64);
alter table ACT_RU_DEADLETTER_JOB add CUSTOM_VALUES_ID_ nvarchar(64);
alter table ACT_RU_HISTORY_JOB add CUSTOM_VALUES_ID_ nvarchar(64);

create index ACT_IDX_JOB_CUSTOM_VALUES_ID on ACT_RU_JOB(CUSTOM_VALUES_ID_);
create index ACT_IDX_TIMER_JOB_CUSTOM_VALUES_ID on ACT_RU_TIMER_JOB(CUSTOM_VALUES_ID_);
create index ACT_IDX_SUSPENDED_JOB_CUSTOM_VALUES_ID on ACT_RU_SUSPENDED_JOB(CUSTOM_VALUES_ID_);
create index ACT_IDX_DEADLETTER_JOB_CUSTOM_VALUES_ID on ACT_RU_DEADLETTER_JOB(CUSTOM_VALUES_ID_);

alter table ACT_RU_JOB
    add constraint ACT_FK_JOB_CUSTOM_VALUES
    foreign key (CUSTOM_VALUES_ID_)
    references ACT_GE_BYTEARRAY (ID_);

alter table ACT_RU_TIMER_JOB
    add constraint ACT_FK_TIMER_JOB_CUSTOM_VALUES
    foreign key (CUSTOM_VALUES_ID_)
    references ACT_GE_BYTEARRAY (ID_);

alter table ACT_RU_SUSPENDED_JOB
    add constraint ACT_FK_SUSPENDED_JOB_CUSTOM_VALUES
    foreign key (CUSTOM_VALUES_ID_)
    references ACT_GE_BYTEARRAY (ID_);

alter table ACT_RU_DEADLETTER_JOB
    add constraint ACT_FK_DEADLETTER_JOB_CUSTOM_VALUES
    foreign key (CUSTOM_VALUES_ID_)
    references ACT_GE_BYTEARRAY (ID_);

update ACT_GE_PROPERTY set VALUE_ = '6.2.1.0' where NAME_ = 'job.schema.version';

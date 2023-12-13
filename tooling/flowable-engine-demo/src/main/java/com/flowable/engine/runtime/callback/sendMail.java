package com.flowable.engine.runtime.callback;

import org.flowable.engine.delegate.DelegateExecution;
import org.flowable.engine.delegate.JavaDelegate;

public class sendMail implements JavaDelegate {
    @Override
    public void execute(DelegateExecution execution) {
        System.out.println("发送email");
    }
}

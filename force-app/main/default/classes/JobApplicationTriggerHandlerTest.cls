@isTest
public with sharing class JobApplicationTriggerTest {

    @isTest
     static void testJobApplicationRelatedTaskAfterInsert(){
        Job_Applications__c[] jobAppList = new Job_Applications__c[] {
            new Job_Applications__c(Name = 'Salesforce Dev', Status__c = 'Saved'),
            new Job_Applications__c(Name = 'Salesforce Admin', Status__c = 'Applying'),
            new Job_Applications__c(Name = 'Salesforce Dev', Status__c = 'Applied'),
            new Job_Applications__c(Name = 'Salesforce Admin', Status__c = 'Interviewing'), 
            new Job_Applications__c(Name = 'Salesforce Dev', Status__c = 'Negotiating'), 
            new Job_Applications__c(Name = 'Salesforce Admin', Status__c = 'Accepted'), 
            new Job_Applications__c(Name = 'Salesforce Dev', Status__c = 'Closed'), 
            new Job_Applications__c(Name = 'Salesforce Admin')};

        Test.startTest();
        insert jobAppList;
        Test.stopTest();

        Map<Id, String> jobIdToStatus = new Map<Id, String>();

        for (Job_Applications__c insertedJob : [SELECT Id, Status__c FROM Job_Applications__c WHERE Id IN :jobAppList]) {
            jobIdToStatus.put(insertedJob.Id, insertedJob.Status__c);
        }

        List<Task> tasksForJob = [SELECT Id, WhatId, Subject FROM Task WHERE WhatId IN :jobIdToStatus.keySet()];
        Map<String, List<Task>> statusTasksMap = new Map<String, List<Task>>();

        for (Task task : tasksForJob) {
            String status = jobIdToStatus.get(task.WhatId);
                if (!statusTasksMap.containsKey(status)) {
                    statusTasksMap.put(status, new List<Task>());
                }
                statusTasksMap.get(status).add(task);
            }

        // List<Task> savedTasks = statusTasksMap.get('Saved');
        // Boolean foundTask = false;
        // for (Task task : savedTasks) {
        //     if (task.Subject.equals('Check if the job description aligns with your interests and values'))
        //     {
        //         foundTask = true;
        //         break;
        //     }
        // }

       // System.assert(foundTask, 'Expected task subject not found for "Saved" status.');
        Assert.areEqual(8, jobAppList.size(),'Expected 8 job applications to be saved');
        Assert.areEqual(1, statusTasksMap.get('Applying').size(), 'Expected 1 tasks for Applying status');
        Assert.areEqual(1, statusTasksMap.get('Applied').size(), 'Expected 1 tasks for Applied status');
        Assert.areEqual(1, statusTasksMap.get('Interviewing').size(), 'Expected 1 tasks for Interviewing status');
        Assert.areEqual(1, statusTasksMap.get('Negotiating').size(), 'Expected 1 tasks for Negotiating status');
        Assert.areEqual(1, statusTasksMap.get('Accepted').size(), 'Expected 1 tasks for Accepted status');
        Assert.areEqual(1, statusTasksMap.get('Closed').size(), 'Expected 1 tasks for Closed status');
        
    }

    @isTest
    static void testJobApplicationRelatedTaskAfterStatusUpdate(){
        Job_Applications__c[] jobAppList = new Job_Applications__c[] {
            new Job_Applications__c(Name = 'Salesforce Dev', Status__c = 'Saved'),
            new Job_Applications__c(Name = 'Salesforce Admin', Status__c = 'Applying'),
            new Job_Applications__c(Name = 'Salesforce Dev', Status__c = 'Applied'),
            new Job_Applications__c(Name = 'Salesforce Admin', Status__c = 'Interviewing'), 
            new Job_Applications__c(Name = 'Salesforce Dev', Status__c = 'Negotiating'), 
            new Job_Applications__c(Name = 'Salesforce Admin', Status__c = 'Accepted')};
        
        Test.startTest();
        insert jobAppList;
        Test.stopTest();
        

        List<Job_Applications__c> jobsToUpdate = new List<Job_Applications__c>();
       
        for(Job_Applications__c jobApp : jobAppList)
        {
            if(jobApp.Status__c == 'Saved')
            {
                jobApp.Status__c = 'Applying';
                jobsToUpdate.add(jobApp);
            }     
            else if(jobApp.Status__c == 'Applying')
            {
                jobApp.Status__c = 'Applied';
                jobsToUpdate.add(jobApp);
            }
            else if(jobApp.Status__c == 'Applied')
            {
                jobApp.Status__c = 'Interviewing';
                jobsToUpdate.add(jobApp);
            }
            else if(jobApp.Status__c == 'Interviewing')
            {
                jobApp.Status__c = 'Negotiating';
                jobsToUpdate.add(jobApp);
            }
            else if(jobApp.Status__c == 'Negotiating')
            {
                jobApp.Status__c = 'Accepted';
                jobsToUpdate.add(jobApp);
            }
            else if(jobApp.Status__c == 'Accepted')
            {
                jobApp.Status__c = 'Closed';
                jobsToUpdate.add(jobApp);
            }
        }

    
        update jobsToUpdate;
        

        Map<Id, String> jobIdToStatus = new Map<Id, String>();

        for (Job_Applications__c updatedJob : [SELECT Id, Status__c FROM Job_Applications__c WHERE Id IN :jobAppList ]) {
            jobIdToStatus.put(updatedJob.Id, updatedJob.Status__c);
        }
        List<Task> tasksForJob = [SELECT Id, WhatId, Subject FROM Task WHERE WhatId IN :jobIdToStatus.keySet()];
        Map<String, List<Task>> statusTasksMap = new Map<String, List<Task>>();

        for (Task task : tasksForJob) {
            String status = jobIdToStatus.get(task.WhatId);
                if (!statusTasksMap.containsKey(status)) {
                    statusTasksMap.put(status, new List<Task>());
                }
                statusTasksMap.get(status).add(task);
            }

        Assert.areEqual(6, statusTasksMap.get('Applying').size(), 'Expected 5 tasks for Applying status');
        Assert.areEqual(5, statusTasksMap.get('Applied').size(), 'Expected 4 tasks for Applied status');
        Assert.areEqual(6, statusTasksMap.get('Interviewing').size(), 'Expected 5 tasks for Interviewing status');
        Assert.areEqual(4, statusTasksMap.get('Negotiating').size(), 'Expected 3 tasks for Negotiating status');
        Assert.areEqual(4, statusTasksMap.get('Accepted').size(), 'Expected 3 tasks for Accepted status');
        Assert.areEqual(3, statusTasksMap.get('Closed').size(), 'Expected 2 tasks for Closed status');


        }


    }
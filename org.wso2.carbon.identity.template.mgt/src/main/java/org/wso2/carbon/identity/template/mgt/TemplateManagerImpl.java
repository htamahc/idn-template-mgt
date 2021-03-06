/*
 * Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package org.wso2.carbon.identity.template.mgt;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.wso2.carbon.identity.template.mgt.dao.TemplateManagerDAO;
import org.wso2.carbon.identity.template.mgt.dao.impl.TemplateManagerDAOImpl;
import org.wso2.carbon.identity.template.mgt.exception.TemplateManagementClientException;
import org.wso2.carbon.identity.template.mgt.exception.TemplateManagementException;
import org.wso2.carbon.identity.template.mgt.model.Template;
import org.wso2.carbon.identity.template.mgt.model.TemplateInfo;

import java.util.List;

import static org.apache.commons.lang.StringUtils.isBlank;
import static org.wso2.carbon.identity.template.mgt.TemplateMgtConstants.ErrorMessages.*;
import static org.wso2.carbon.identity.template.mgt.util.TemplateMgtUtils.getTenantIdFromCarbonContext;
import static org.wso2.carbon.identity.template.mgt.util.TemplateMgtUtils.handleClientException;


/**
 * Template manager service implementation.
 */
public class TemplateManagerImpl implements  TemplateManager {

    private static final Log log = LogFactory.getLog(TemplateManagerImpl.class);
    private static final Integer DEFAULT_SEARCH_LIMIT = 100;

    @Override
    public TemplateInfo addTemplate(Template template) throws TemplateManagementException {
        validateInputParameters(template);
        TemplateManagerDAO templateManagerDAO = new TemplateManagerDAOImpl();
        return templateManagerDAO.addTemplate(template);
    }

    @Override
    public Template getTemplateByName(String templateName) throws TemplateManagementException {
        TemplateManagerDAO templateManagerDAO = new TemplateManagerDAOImpl();
        return templateManagerDAO.getTemplateByName(templateName, getTenantIdFromCarbonContext());
    }

    @Override
    public TemplateInfo updateTemplate(String templateName, Template template) throws TemplateManagementException {
        validateInputParameters(template);
        TemplateManagerDAO templateManagerDAO = new TemplateManagerDAOImpl();
        return templateManagerDAO.updateTemplate(templateName,template);
    }

    @Override
    public String deleteTemplate(String templateName) throws TemplateManagementException {
        TemplateManagerDAO templateManagerDAO = new TemplateManagerDAOImpl();
        return templateManagerDAO.deleteTemplate(templateName, getTenantIdFromCarbonContext());
    }

    @Override
    public List<TemplateInfo> listTemplates(Integer limit, Integer offset) throws TemplateManagementException {

        validatePaginationParameters(limit,offset);
        
        if (limit == 0) {
            limit = DEFAULT_SEARCH_LIMIT;
            if (log.isDebugEnabled()) {
                log.debug("Limit is not defined in the request, default to: " + limit);
            }
        }

        TemplateManagerDAO templateManagerDAO = new TemplateManagerDAOImpl();
        return templateManagerDAO.getAllTemplates(getTenantIdFromCarbonContext(),limit,offset);
    }

    private void validateInputParameters(Template template) throws TemplateManagementClientException {
        if (isBlank(template.getTemplateName())){
            if (log.isDebugEnabled()){
                log.debug("Template name cannot be empty");
            }
            throw handleClientException(ERROR_CODE_TEMPLATE_NAME_REQUIRED, null);
        }

        if (isBlank(template.getTemplateScript())){
            if (log.isDebugEnabled()){
                log.debug("Template script cannot be empty");
            }
            throw handleClientException(ERROR_CODE_TEMPLATE_SCRIPT_REQUIRED, null);
        }

        if (template.getTenantId() == null){
            template.setTenantId(getTenantIdFromCarbonContext());
        }

    }

    private void validatePaginationParameters(Integer limit, Integer offset) throws TemplateManagementClientException {

        if (limit < 0 || offset < 0) {
            throw handleClientException(ERROR_CODE_INVALID_ARGUMENTS_FOR_LIMIT_OFFSET, null);
        }
    }



}

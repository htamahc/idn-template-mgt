/*
 * Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.wso2.carbon.template.mgt.util;


import org.apache.commons.lang.StringUtils;
import org.wso2.carbon.template.mgt.TemplateMgtConstants;
import org.wso2.carbon.template.mgt.exception.TemplateManagementServerException;

/**
 * This class is used to define the Utilities required in template management feature.
 */
public class TemplateMgtUtils {

    /**
     * This method can be used to generate a TemplateManagementServerException from IdentityTemplateMgtConstants.ErrorMessages
     * object when no exception is thrown.
     *
     * @param error IdentityTemplateMgtConstants.ErrorMessages.
     * @param data  data to replace if the message needs to be replaced.
     * @return ConsentManagementServerException.
     */
    public static TemplateManagementServerException handleServerException(TemplateMgtConstants.ErrorMessages error,
                                                                          String data, Throwable e) {
        String message;
        if (StringUtils.isNotBlank(data)) {
            message = String.format(error.getMessage(), data);
        } else {
            message = error.getMessage();
        }
        return new TemplateManagementServerException(message, error.getCode(), e);
    }
}

<%@ page import="org.wso2.carbon.utils.ServerConstants" %>
<%@ page import="org.apache.axis2.context.ConfigurationContext" %>
<%@ page import="org.wso2.carbon.CarbonConstants" %>
<%@ page import="org.wso2.carbon.ui.CarbonUIMessage" %>
<%@ page import="org.wso2.carbon.ui.CarbonUIUtil" %>
<%@ page import="org.wso2.carbon.identity.template.mgt.model.Template" %>
<%@ page import="org.wso2.carbon.context.PrivilegedCarbonContext" %>
<%@ page import="org.wso2.carbon.identity.template.mgt.ui.client.TemplateManagementServiceClient" %>
<%@ page import="org.wso2.carbon.identity.template.mgt.ui.dto.TemplateRequestDTO" %>

<%--
  ~ Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
  ~
  ~ WSO2 Inc. licenses this file to you under the Apache License,
  ~ Version 2.0 (the "License"); you may not use this file except
  ~ in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied. See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  --%>

<%
    String httpMethod = request.getMethod();
    if (!"post".equalsIgnoreCase(httpMethod)) {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        return;
    }

    String templateName = request.getParameter("templateName");
    String description = request.getParameter("template-description");
    String templateScript = request.getParameter("scriptTextArea");

    Integer tenantId = PrivilegedCarbonContext.getThreadLocalCarbonContext().getTenantId();

    if (templateName != null && !"".equals(templateName)) {

        TemplateRequestDTO templateRequestDTO = new TemplateRequestDTO();
        templateRequestDTO.setTenantId(tenantId);
        templateRequestDTO.setTemplateName(templateName);
        templateRequestDTO.setDescription(description);
        templateRequestDTO.setTemplateScript(templateScript);

        try{
            String currentUser = (String) session.getAttribute("logged-user");
            TemplateManagementServiceClient serviceClient = new TemplateManagementServiceClient(currentUser);
            serviceClient.addTemplate(templateRequestDTO);

%>
<script>
    location.href = 'list-templates.jsp';
</script>
<%
} catch (Exception e) {
    CarbonUIMessage.sendCarbonUIMessage(e.getMessage(), CarbonUIMessage.ERROR, request, e);
    e.printStackTrace();
%>
<script>
    location.href = 'add-template.jsp';
</script>
<%
    }
}else{
%>
<script>
    location.href = 'add-template.jsp';
</script>
<%
    }%>



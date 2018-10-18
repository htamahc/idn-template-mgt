<link rel="stylesheet" href="codemirror/lib/codemirror.css">
<link rel="stylesheet" href="codemirror/theme/mdn-like.css">
<link rel="stylesheet" href="codemirror/addon/dialog/dialog.css">
<link rel="stylesheet" href="codemirror/addon/display/fullscreen.css">
<link rel="stylesheet" href="codemirror/addon/fold/foldgutter.css">
<link rel="stylesheet" href="codemirror/addon/hint/show-hint.css">
<link rel="stylesheet" href="codemirror/addon/lint/lint.css">

<link rel="stylesheet" href="css/template-mgt.css">
<link rel="stylesheet" href="css/template.css">

<script src="codemirror/lib/codemirror.js"></script>
<script src="codemirror/keymap/sublime.js"></script>
<script src="codemirror/mode/xml/xml.js"></script>
<script src="codemirror/mode/css/css.js"></script>
<script src="codemirror/mode/javascript/javascript.js"></script>
<script src="codemirror/mode/htmlmixed/htmlmixed.js"></script>

<script src="codemirror/addon/lint/jshint.min.js"></script>
<script src="codemirror/addon/lint/lint.js"></script>
<script src="codemirror/addon/lint/javascript-lint.js"></script>
<script src="codemirror/addon/lint/html-lint.js"></script>
<script src="codemirror/addon/lint/css-lint.js"></script>

<script src="codemirror/addon/hint/anyword-hint.js"></script>
<script src="codemirror/addon/hint/show-hint.js"></script>
<script src="codemirror/addon/hint/javascript-hint.js"></script>
<script src="codemirror/addon/hint/wso2-hints.js"></script>
<script src="codemirror/addon/hint/html-hint.js"></script>
<script src="codemirror/addon/hint/htmlhint.js"></script>
<script src="codemirror/addon/hint/css-hint.js"></script>
<script src="codemirror/addon/hint/xml-hint.js"></script>

<script src="codemirror/addon/edit/matchtags.js"></script>
<script src="codemirror/addon/edit/closetag.js"></script>
<script src="codemirror/addon/edit/closebrackets.js"></script>
<script src="codemirror/addon/edit/matchbrackets.js"></script>
<script src="codemirror/addon/fold/brace-fold.js"></script>
<script src="codemirror/addon/fold/foldcode.js"></script>
<script src="codemirror/addon/fold/foldgutter.js"></script>
<script src="codemirror/addon/fold/xml-fold.js"></script>

<script src="codemirror/addon/display/fullscreen.js"></script>
<script src="codemirror/addon/display/placeholder.js"></script>
<script src="codemirror/addon/comment/comment.js"></script>
<script src="codemirror/addon/selection/active-line.js"></script>
<script src="codemirror/addon/dialog/dialog.js"></script>
<script src="codemirror/addon/display/panel.js"></script>
<script src="codemirror/util/formatting.js"></script>

<script type="text/javascript" src="../identity/validation/js/identity-validate.js"></script>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="carbon" uri="http://wso2.org/projects/carbon/taglibs/carbontags.jar"%>

<carbon:breadcrumb label="breadcrumb.template.mgt" resourceBundle="org.wso2.carbon.identity.template.mgt.ui.i18n.Resources" topPage="true" request="<%=request%>" />
<jsp:include page="../dialog/display_messages.jsp" />

<script type="text/javascript">
    function createTemplateOnclick() {
        var templateName = document.getElementById("templateName").value.trim();
        var description = document.getElementById("template-description").value;
        if( templateName == '') {
            CARBON.showWarningDialog('Template name cannot be empty');
            location.href = '#';
        } else if (!validateTextForIllegal(document.getElementById("templateName"))) {
            return false;
        }else {
            $("#add-template-form").submit();
            return true;
        }
    }
    function validateTextForIllegal(fild) {
        var isValid = doValidateInput(fild, "Provided template name is invalid");
        if (isValid) {
            return true;
        } else {
            return false;
        }
    }
    var openFile = function (event) {
        var input = event.target;
        var reader = new FileReader();
        reader.onload = function () {
            var data = reader.result;
            document.getElementById('template-file-content').value = data;
        };
        document.getElementById('template-file-name').value = input.files[0].name;
        reader.readAsText(input.files[0]);
    };
    function importTemplateOnclick() {

    }
    function showManual() {
        $("#add-template-form").show();
        $("#upload-template-form").hide();
    }
    function showFile() {
        $("#add-template-form").hide();
        $("#upload-template-form").show();
    }

    window.onload = function() {
        showManual();
    }

</script>

<fmt:bundle basename="org.wso2.carbon.identity.template.mgt.ui.i18n.Resources">

    <div id="middle">
        <h2>Add New Template</h2>
        <div id="workArea">
            <table class="styledLeft" width="100%">
                <thead>
                <tr>
                    <th><fmt:message key="title.template.select.mode"/></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td><input type="radio" id="manual-option" name="upload-type-selector" checked="checked"
                               onclick="showManual();">
                        <label for="manual-option">Manual Configuration</label>
                    </td>

                </tr>
                <tr>
                    <td>
                        <input type="radio" id="file-option" name="upload-type-selector" onclick="showFile();">
                        <label for="file-option">File Configuration</label>
                    </td>
                </tr>

                </tbody>
            </table>
            <br/>
            <form id="add-template-form" name="add-template-form" method="post"
                  action="add-template-finish.jsp">
                <div class="sectionSeperator togglebleTitle"><fmt:message key='title.config.template.basic.config'/></div>
                <div class="sectionSub">
                    <table class="carbonFormTable">
                        <tr>
                            <td style="width:15%" class="leftCol-med labelField"><fmt:message key='config.template.info.basic.name'/>:<span class="required">*</span></td>
                            <td>
                                <input id="templateName" name="templateName" type="text" value="" white-list-patterns="^[a-zA-Z0-9\s._-]*$" autofocus/>
                                <div class="sectionHelp">
                                    <fmt:message key='help.name'/>
                                </div>
                            </td>
                        </tr>
                        <tr>


                            <td class="leftCol-med labelField">Description:</td>
                            <td>
                                <textarea style="width:50%" type="text" name="template-description" id="template-description" class="text-box-big"></textarea>
                                <div class="sectionHelp">
                                    <fmt:message key='help.desc'/>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <h2 id="authentication_step_config_head" class="sectionSeperator trigger active">
                    <a href="#">Template Script</a>
                </h2>
                <div class="toggle_container" id="editorRow">
                    <div style="position: relative;">
                        <div id="codeMirror" class="sectionSub step_contents" >
            <textarea id="scriptTextArea" name="scriptTextArea"
                      placeholder="Write Custom Template..."
                      style="height: 500px;width: 100%; display: none;">

            </textarea>
                        </div>
                        <!-- <div id="codeMirrorTemplate" class="step_contents">
                             <div class="add-template-container vertical-text">
                                 <a id="addFunctionlib" class="icon-link noselect">Function Libraries</a>
                             </div>
                             <div class="template-list-container">
                                 <ul id="template_list"></ul>
                             </div>
                         </div>-->

                    </div>

                </div>

                <div style="clear:both"></div>
                <div class="buttonRow" style=" margin-top: 10px;">
                    <input id="createLib" type="button" value="<fmt:message key='button.reg.template.manager'/>"  onclick="createTemplateOnclick()"/>
                    <input type="button" onclick="javascript:location.href='list-templates.jsp'" value="<fmt:message key='button.cancel'/>" />
                </div>
            </form>

            <form id="upload-template-form" name="upload-template-form" method="post"
                  action="#">
                <table class="styledLeft" width="100%">
                    <thead>
                    <tr>
                        <th><fmt:message key="upload.template.file"/></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <span>File Location: </span><input type="file" class="button" id="template_file" name="template_file" onchange='openFile(event)'/>
                        </td>
                        <textarea hidden="hidden" name="template-file-content" id="template-file-content"></textarea>
                        <textarea hidden="hidden" name="template-file-name" id="template-file-name"></textarea>
                    </tr>
                    <tr>
                        <td>
                            <input type="button" class="button"  value="<fmt:message key='button.import.template'/>"
                                   onclick="importTemplateOnclick();"/>
                            <input type="button" class="button" onclick="javascript:location.href='list-templates.jsp'" value="<fmt:message key='button.cancel'/>" />
                        </td>
                    </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </div>
</fmt:bundle>
<script src="./js/template-mgt.js"></script>

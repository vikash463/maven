<%@ taglib prefix="sm" uri="http://jsmartframework.com/v2/jsp/taglib/jsmart" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>JSmart Framework - Dynamic Scroll Archetype</title>
    </head>

    <body class="container">

        <!-- Example list and table handling -->

        <div class="col-md-6" style="margin-top: 50px;">

            <sm:alert id="feedback">
                <!-- Message will be added via WebContext on HomeBean -->
            </sm:alert>

            <sm:form>
                <sm:output type="p" value="Enter name and age to be included on list" style="text-align: center;" />

                <sm:input id="name-id" label="Name" placeholder="Enter name" value="@{homeBean.name}">
                    <sm:validate look="warning" text="Name must be valid" />
                </sm:input>

                <sm:input id="age-id" type="number" label="Age" placeholder="Enter age" value="@{homeBean.age}">
                    <sm:validate look="warning" text="Age must be valid" />
                </sm:input>

                <!-- Button to send form content via Ajax and update the list -->
                <sm:button id="add-btn" ajax="true" label="Send" action="@{homeBean.addContent}" update="list"
                        style="margin-top: 10px;" beforeSend="updateActionTables();" look="warning">
                    <sm:load />
                    <sm:icon name="glyphicon-pencil" style="margin-right: 5px;" />
                </sm:button>

            </sm:form>
        </div>

        <div class="col-md-6" style="margin-top: 50px;">
            <sm:list id="list" values="@{homeBean.myListAdapter}" var="item" scrollSize="5" maxHeight="280px;">

                <!-- Load component will present loading when request is done to get more list items via scroll -->
                <sm:load type="h4" label=" Loading ..." />

                <!-- Template to create each list row -->
                <sm:row>
                    <sm:header type="h5" title="@{item.name}" />

                    <sm:output value="Username description ;)" />

                    <sm:badge label="@{item.age}" />
                </sm:row>

                <!-- Component to present content when list is empty -->
                <sm:empty style="color: #ddd; font-size: 18px; text-align: center;">
                    <sm:icon name="glyphicon-user" />
                    <sm:output value="No items found on list" />
                </sm:empty>

            </sm:list>
        </div>

        <div class="col-md-12" style="margin-top: 10px; clear: both;">

            <!-- Table to work as template so we can add rows via JSmart function -->
            <sm:table id="table" style="overflow-x: hidden;" scrollSize="5" maxHeight="150px;" striped="true">

                <sm:column label="Name">
                    <sm:output id="name-row-id" />
                </sm:column>

                <sm:column label="Age">
                    <sm:output id="age-row-id" />
                </sm:column>

                <sm:column label="Action">
                    <sm:output id="action-row-id" />
                </sm:column>

                <sm:empty style="color: #ddd; font-size: 18px; text-align: center; padding: 30px;">
                    <sm:icon name="glyphicon-bell" />
                    <sm:output value="No actions found on table" />
                </sm:empty>
            </sm:table>
        </div>


        <script type="text/javascript">

            /*!
             * Called before action via Ajax is done on server to keep track of clients action
             */
            function updateActionTables() {
                if (JSmart.isEmpty('table')) {
                    JSmart.hideEmpty('table');
                }
                var name = $('#name-id').val();
                var age =  $('#age-id').val();

                var row = JSmart.createRow('table');

                row.find('span[id="name-row-id"]').text(name);
                row.find('span[id="age-row-id"]').text(age);
                row.find('span[id="action-row-id"]').text('Included user [' + name + '] with age [' + age + '] to list!');
            }
        </script>
    </body>

</html>
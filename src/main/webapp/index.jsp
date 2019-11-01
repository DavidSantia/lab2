<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Example</title>
    </head>
    <body bgcolor="silver">
        <form method="post" action="process">
            <center>
            <table border="0" width="80%" cellpadding="3">
                <thead>
                    <tr>
                        <th colspan="2">Text Stats</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Enter text to process</td>
                    </tr>
                    <tr>
                        <td><textarea name="data" style="width: 100%;" rows="40" cols="100"></textarea></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Process" /></td>
                    </tr>
                </tbody>
            </table>
            </center>
        </form>
    </body>
</html>


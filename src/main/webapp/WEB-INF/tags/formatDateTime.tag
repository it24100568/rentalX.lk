<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ tag import="java.time.LocalDateTime" %>
<%@ tag import="java.time.format.DateTimeFormatter" %>
<%@ attribute name="value" required="true" type="java.time.LocalDateTime" %>
<%@ attribute name="pattern" required="true" type="java.lang.String" %>
<%
    if (value != null) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(pattern);
        out.print(value.format(formatter));
    }
%> 
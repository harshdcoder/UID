<%@ page import="java.util.*,java.sql.*" %>

<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.io.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>

<%
java.util.Date dt;
int dy,mn,yr;
String tdt,cno;
int appno,pin;
String cname,caddr,dob,fname,occ,ph,gend;
Connection con;
Statement stmt,stmt1;
ResultSet rs;
%>

<%
appno=1;
tdt="";
dt=new java.util.Date();
dy=dt.getDate();
mn=dt.getMonth()+1;
yr=dt.getYear()+1900;
tdt=dy+"/"+mn+"/"+yr;
%>


<%


	MultipartRequest mpr=new MultipartRequest(request,application.getRealPath("image"),1024*1024*1024);



try{
out.println("<body background='light_blue1.bmp'>");
cname=mpr.getParameter("cname");
caddr=mpr.getParameter("addr");
dob=mpr.getParameter("dob");
fname=mpr.getParameter("fname");
cno=mpr.getParameter("cno");
occ=mpr.getParameter("occ");
ph=mpr.getOriginalFileName("ph");
gend=mpr.getParameter("r1");
pin=Integer.parseInt(mpr.getParameter("pin"));

Class.forName("oracle.jdbc.driver.OracleDriver");
con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","rishi","rishi");

stmt1=con.createStatement();
rs=stmt1.executeQuery("select max(appno) from cregn");
try
{
if (rs.next())
appno=rs.getInt(1) + 1;
}
catch(Exception ee)
{
appno=1;
out.println(ee.getMessage());
}
stmt=con.createStatement();
stmt.executeUpdate("insert into cregn values(" + appno + ",0,'0'" + ",'" + cname + "','" + caddr + "','" + dob + "','" + fname + "'," + cno + ",'" + occ + "','" + ph + "'," + pin + ",'" + gend + "','Processing')" );
out.println("Registration Succesfull for application " + appno);
}
catch(Exception ee)
{
out.println("Invalid Data! All fields are mandatory..." + ee.getMessage());
}

%>
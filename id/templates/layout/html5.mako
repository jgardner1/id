<!doctype html>
<%def name="head()">\
  <meta charset="utf-8">
  <title>${self.title()}</title>  
  <!--[if lt IE 9]>  
  <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>  
  <![endif]-->
</%def>\
<%def name="title()">Jonathan's ID Server</%def>\
<html lang="en">
<head>
${self.head()}
</head>
<body>${next.body()}</body>
</html>

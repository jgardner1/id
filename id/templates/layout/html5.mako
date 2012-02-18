<!doctype html>
<%def name="head()">\
  <meta charset="utf-8">
  <title>${self.title()}</title>  
  <!--[if lt IE 9]>
    <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->
</%def>\
<%def name="title()">Jonathan's ID Server</%def>\
<html lang="en">
<head>
${self.head()}
</head>
<body>
${next.body()}\
<script src="${url('http://code.jquery.com/jquery-1.7.1.min.js')}"></script>
<script src="${url('/js/bootstrap.min.js')}"></script>
</body>
</html>

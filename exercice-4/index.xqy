xquery version "1.0-ml";

declare variable $debug := xdmp:get-request-field("debug", "");
declare variable $content-type := if ($debug = '') then("text/html; charset=utf-8") else("text/xml");

declare variable $url := xdmp:get-request-field("url", "");
(:exemples : 
https://www.gchagnon.fr/cours/xml
https://www.gchagnon.fr/cours/xml/stylexsl.html
https://www.lefebvre-sarrut.eu/nous-connaitre/
https://fabien-torre.fr/Enseignement/Cours/XML/base.php
https://www.deedeeparis.com/blog/meditation-yoga-boxe-quelques-activites-gratuites-en-ligne-pour-mieux-vivre-le-confinement
:)
declare variable $url-doc := if ($url) then xdmp:http-get($url) else ();
declare variable $url-doc-clean := xdmp:tidy($url-doc/text());
declare variable $url-doc-clean-body := $url-doc-clean//*:body[1];

xdmp:set-response-content-type($content-type),
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Exercice TDM</title>
    <link href="layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
      var url = '{$url}';
    </script>
    <script src="script.js" type="text/javascript"><!--u--></script>
  </head>
  <body>
    <div class="wrapper">
      <h1>Le web avec TDM !</h1>
      <header>
        <form method="get" action="index.xqy">
        Site : <input type="text" style="width:70%;" name="url" id="url" action="index.xqy" value="{$url}"/>
        </form>
      </header>
      <nav>
      <!--<div style="display:none">{$url-doc-clean}</div>-->
      {
        let $params := map:map()
        let $_put := map:put($params, 'url', $url)
        return
        if($url-doc-clean-body[1]/*)
        then (xdmp:xslt-invoke('/genTDM.xsl', $url-doc-clean-body[1], $params))
        else (<p>erreur</p>, $url-doc-clean[1])
      }
      </nav>
      <section>
      {(:xdmp:document-get($url, 
      <options xmlns="xdmp:document-get">
           <repair>full</repair>
           <format>xml</format>
       </options>):)}
        {(:$url-doc-clean-body/*:)}
        <iframe id="iframe" width="740" height="1000" src="{$url}"
                onload="alert(this.contentWindow.location.href);"/>
      </section>
    </div>
  </body>
</html>
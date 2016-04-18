<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<!--
This file is modified by Charles Chen based on index.html from
Online Python Tutor https://github.com/pgbovine/OnlinePythonTutor/.

Major modifications:
1. change display layout adapt to Checker Framework purpose
2. change plain html to template of bottle, in order dynamically
   generate the absolute url of static scripts and also backend url.

== The original description of index.html is as below ==

Online Python Tutor
https://github.com/pgbovine/OnlinePythonTutor/

Copyright (C) Philip J. Guo (philip@pgbovine.net)

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

-->

<head>
  <title>Checker Framework Live Demo</title>

  <meta http-equiv="Content-type" content="text/html; charset=UTF-8"/>

  <!-- requirements for pytutor.js -->
  <script type="text/javascript" src="{{ get_url('static', filepath='js/jquery/jquery-1.8.2.min.js') }}"></script>
  <script type="text/javascript" src="{{ get_url('static', filepath='js/jquery/jquery.ba-bbq.min.js') }}"></script> <!-- for handling back button and URL hashes -->
  <script type="text/javascript" src="{{ get_url('static', filepath='js/jquery/jquery.ba-dotimeout.min.js') }}"></script> <!-- for event debouncing -->

  <script type="text/javascript" src="{{ get_url('static', filepath='js/jquery/jquery-ui-1.8.24.custom.min.js') }}"></script> <!-- for sliders and other UI elements -->
  <link type="text/css" href="{{ get_url('static', filepath='css/jquery-ui-1.8.24.custom.css') }}" rel="stylesheet" />

  <!-- requirements for cf-frontend.js -->

  <!-- Ace online code editor -->
  <script type="text/javascript" src="{{ get_url('static', filepath='js/ace/src-min-noconflict/ace.js') }}" charset="utf-8"></script>

  <script type="text/javascript" src="{{ get_url('static', filepath='js/cf-frontend.js') }}"></script>
  <link rel="stylesheet" href="{{ get_url('static', filepath='css/cf-frontend.css') }}"/>
  <script type="text/javascript" src="{{ get_url('static', filepath='js/cf-load-examples.js') }}"></script>
</head>


<body>
  <div class = "header">
    <header>Checker Framework Live Demo</header>
  </div>


<!-- backend url for getting static file and exec user code
    generated by Bottle.get_url for getting the correct url when mount
    to apache2 mode_wsgi
-->
<div id="static_url_prefix" data-static-url-prefix="{{ get_url('static', filepath='') }}"></div>
<div id="exec_url" data-exec-url="{{ get_url('exec') }}"></div>

<div id="pyInputPane">

  <div id="codeInputWarnings">Write Java code here:</div>
  <div id="resizable_codeInput">
  <div id="codeInputPane"></div> <!-- populate with a Ace code editor instance -->
  </div>
  <div id="ck_inputPane">
    <div id="javaOptionsPane" style="margin-top: 20px;">
      Choose a type system:
      <select id="type_system">
	<option value="aliasing">Aliasing Checker</option>
	<option value="cons_value">Constant Value Checker</option>
	<option value="fake_enum">Fake Enum Checker</option>
	<option value="format_string">Format String Checker</option>
	<option value="gui_effect">GUI Effect Checker</option>
	<option value="igj">IGJ Checker</option>
	<option value="interning">Interning Checker</option>
	<option value="javari">Javari Checker</option>
	<option value="linear">Linear Checker</option>
	<option value="lock">Lock Checker</option>
	<option value="nullness">Nullness Checker</option>
	<option value="regex">Regex Checker</option>
	<option value="signature">Signature Checker</option>
	<option value="tainting">Tainting Checker</option>
	<option value="units">Units Checker</option>
      </select><br/>

      <!-- comming soon! -->
      <!--  <div id="cfgPane" style="display: none;">
	<input id="cfg" type="checkbox" />Generate Control Flow Graph

	<select id="cfg_level" style="display: none;">
	  <option value="top_level">Top Level</option>
	  <option value="only_type">Only Type</option>
	  <option value="basic_block">Basic Block</option>
	  <option value="full_details">Full Details</option>
	</select><br/>
      </div> -->
      <!-- <input id="verbose" type="checkbox"/>verbose<br/> -->
    </div>

    <p>
      <button id="executeBtn" class="bigBtn" type="button">Check</button>
    </p>
  </div>

  <div id="frontendInfoOutput"></div>

  <div id="reportPane" style="display: none;">
    <div id="exec_cmd"></div>
    <table id="error_table">
      <tr>
        <th>NO.</th>
        <th>Type</th>
        <th>Description</th>
        <th>Line</th>
        <th>Column</th>
      </tr>
    </table>
  </div>

  <div id="examplesPane">
    <p style="margin-top: 25px; font-weight: bold;">Examples:</p>

    <p data-checker-type="nullness">
      Nullness:
      <a class="exampleLink" id="NullnessExampleLink" href="#">NullnessExample</a> |
      <a class="exampleLink" id="NullnessExampleWithWarningsLink" href="#">NullnessExampleWithWarnings</a>
    </p>

    <p data-checker-type="nullness">
      MapKey:
      <a class="exampleLink" id="MapKeyExampleWithWarningsLink" href="#">MapKeyExampleWithWarnings</a>
    </p>

    <p data-checker-type="interning">
      Interning:
      <a class="exampleLink" id="InterningExampleLink" href="#">InterningExample</a> |
      <a class="exampleLink" id="InterningExampleWithWarningsLink" href="#">InterningExampleWithWarnings</a>
    </p>

    <p data-checker-type="lock">
      Lock:
      <a class="exampleLink" id="GuardedByExampleWithWarningsLink" href="#">GuardedByExampleWithWarnings</a> |
      <a class="exampleLink" id="HoldingExampleWithWarningsLink" href="#">HoldingExampleWithWarnings</a> |
      <a class="exampleLink" id="EnsuresLockHeldExampleLink" href="#">EnsuresLockHeldExample</a> |
      <a class="exampleLink" id="LockingFreeExampleWithWarningsLink" href="#">LockingFreeExampleWithWarnings</a>
    </p>

    <p data-checker-type="fake_enum">
      Fake Enumeration:
      <a class="exampleLink" id="FakeEnumExampleWithWarningsLink" href="#">FakeEnumExampleWithWarnings</a>
    </p>

    <p data-checker-type="format_string">
      Format String:
      <a class="exampleLink" id="FormatStringExampleWithWarningsLink" href="#">FormatStringExampleWithWarnings</a>
      <!-- <a class="exampleLink" id="FormatStringMissedAlarmsLink" href="#">FormatStringMissedAlarms</a> | -->
    </p>

    <p data-checker-type="regex">
      Regular Expression:
      <a class="exampleLink" id="RegexExampleWithWarningsLink" href="#">RegexExampleWithWarnings</a> |
      <a class="exampleLink" id="RegexConcatenationExampleLink" href="#">RegexConcatenationExample</a>
    </p>

    <!-- <p data-checker-type="linear">
      Linear:
      <a class="exampleLink" id="LinearExampleWithWarningsLink" href="#">LinearExampleWithWarnings</a> |
    </p> -->

    <p data-checker-type="igj">
      IGJ immutability:
      <a class="exampleLink" id="IGJExampleWithWarningsLink" href="#">IGJExampleWithWarnings</a>
    </p>

    <p data-checker-type="javari">
      Javari immutability:
      <a class="exampleLink" id="JavariExampleWithWarningsLink" href="#">JavariExampleWithWarnings</a>
    </p>

    <p data-checker-type="tainting">
      Tainting:
      <a class="exampleLink" id="TaintingExampleWithWarningsLink" href="#">TaintingExampleWithWarnings</a>
    </p>

    <p data-checker-type="signature">
      Signature Strings:
      <a class="exampleLink" id="SignatureExampleWithWarningsLink" href="#">SignatureExampleWithWarnings</a> |
      <a class="exampleLink" id="SignatureExampleLink" href="#">SignatureExample</a>
    </p>

    <p data-checker-type="gui_effect">
      GUI Effect:
      <a class="exampleLink" id="GUIEffectExampleWithWarningsLink" href="#">GUIEffectExampleWithWarnings</a>
    </p>

    <p data-checker-type="units">
      Units:
      <a class="exampleLink" id="SimpleDemoWithWarningsLink" href="#">SimpleDemoWithWarnings</a> |
      <a class="exampleLink" id="MethodsDemoWithWarningsLink" href="#">MethodsDemoWithWarnings</a> |
      <a class="exampleLink" id="PolyUnitDemoWithWarningsLink" href="#">PolyUnitDemoWithWarnings</a>
    </p>
  </div>
</div>

<div id="footer">
  <div class = "footer_left">
      <p>For more information see
      <a href="http://checkerframework.org/">http://checkerframework.org/</a>
      and
      <a href=" http://eisop.uwaterloo.ca/">http://eisop.uwaterloo.ca/</a>
      </p>
      <p>
    Built with code from the amazing
      <a href="http://pythontutor.com/">Python Tutor</a>
      (<a href="https://github.com/pgbovine/OnlinePythonTutor/">Original sources</a>, <a href="https://github.com/daveagp/java_jail">Original java-backend sources</a>).
      <a href="https://github.com/eisop/webserver/">GitHub sources for the Checker Framework Live Demo</a>.
      </p>
  </div>
  <div class = "footer_right">
    <img src="{{ get_url('static', filepath='img/CFLogo.png') }}" alt="Checker Framework logo" style=""/>
  </div>
</div>

</body>
</html>

<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output 
    encoding="UTF-8"
    indent="yes"
    method="xml"
    omit-xml-declaration="yes" 
  />

  <xsl:template match="Page">
    <html>
      <head>
        <title>
          <xsl:value-of select="Title" />
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <xsl:call-template name="create-default-style" />
        <xsl:call-template name="create-default-script" />
      </head>
      <body>
        <!-- HEADER -->
        <xsl:call-template name="create-default-collection-title" />
        <xsl:call-template name="create-index" />
        <xsl:call-template name="create-default-title" />
        <xsl:call-template name="create-default-summary" />
        <xsl:call-template name="create-default-signature" />
        <xsl:call-template name="create-default-remarks" />
        <xsl:call-template name="create-default-members" />
        <hr size="1" />
        <xsl:call-template name="create-default-copyright" />
      </body>
    </html>
  </xsl:template>

  <!-- IDENTITY TRANSFORMATION -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template name="create-default-style">
    <style>
      body { font-family: Verdana; background-color: black; color: gray }

      a { text-decoration: none /*underline*/; color: yellow }

      div.SideBar {
        padding-left: 1em;
        padding-right: 1em;
        right: 0;
        float: right;
        border: thin solid white;
        background-color: black;
      }
    
      .CollectionTitle { font-weight: bold }
      .PageTitle { font-size: 150%; font-weight: bold }

      .Summary { }
      .Signature { font-family: Consolas }          
      .Remarks { }
      .Members { }
      .Copyright { }
      
      .Section { font-size: 100%; font-weight: bold }
      p.Summary {
        margin-left: 1em;
      }
      .SectionBox { margin-left: 2em }
      .NamespaceName { font-size: 105%; font-weight: bold }
      .NamespaceSumary { }
      .MemberName { font-size: 115%; font-weight: bold; margin-top: 1em }
      .Subsection { font-size: 105%; font-weight: bold }
      .SubsectionBox { margin-left: 2em; margin-bottom: 1em }

      .CodeExampleTable { background-color: black; border: thin solid black; padding: .25em; }
      
      .TypesListing {
        border-collapse: collapse;
      }

      td {
        vertical-align: top;
      }
      th {
        text-align: left;
      }

      .TypesListing td { 
        margin: 0px;  
        padding: .25em;
        border: solid gray 1px;
      }

      .TypesListing th { 
        margin: 0px;  
        padding: .25em;
        background-color: black;
        border: solid gray 1px;
      }

      div.Footer {
        border-top: 1px solid gray;
        margin-top: 1.5em;
        padding-top: 0.6em;
        text-align: center;
        color: gray;
      }

      span.NotEntered /* Documentation for this section has not yet been entered */ {
        font-style: italic;
        color: red;	
      }

      div.Header {
        background: black;
        border: double;
        border-color: white;
        border-width: 7px;
        padding: 0.5em;
      }

      div.Header * {
        font-size: smaller;
      }

      div.Note {
      }

      i.ParamRef {
      }

      i.subtitle {
      }

      ul.TypeMembersIndex {
        text-align: left;
        background: #F8F8F8;
      }

      ul.TypeMembersIndex li {
        display: inline;
        margin:  0.5em;
      }

      table.HeaderTable {
      }

      table.SignatureTable {
      }

      table.Documentation, table.Enumeration, table.TypeDocumentation {
        border-collapse: collapse;
        width: 100%;
      }

      table.Documentation tr th {
        background-color: black;
        /*background: whitesmoke;*/
        padding: 0.8em;
        border: 1px solid gray;
        text-align: left;
        vertical-align: bottom;
      }

      table.Documentation tr td {
        padding: 0.5em;
        border: 1px solid gray;
        text-align: left;
        vertical-align: top;
      }

      table.TypeMembers tr th, table.Enumeration tr th, table.TypeDocumentation tr th {
        background-color: black;
        /*background: whitesmoke;*/
        padding: 0.8em;
        border: 1px solid gray;
        text-align: left;
        vertical-align: bottom;
      }

      table.TypeMembers tr td, table.Enumeration tr td, table.TypeDocumentation tr td {
        padding: 0.5em;
        border: 1px solid gray;
        text-align: left;
        vertical-align: top;
      }

      table.TypeMembers {
        color: white;
        font-size: 85%;
        border: 1px solid #C0C0C0;
        width: 100%;
      }

      table.TypeMembers tr td {
        background: black;
        border: white;
      }

      table.Documentation {
      }

      table.TypeMembers {
        font-family: Consolas
      }

      div.CodeExample {
        font-family: Consolas;
        width: 100%;
        border: 1px solid #DDDDDD;
        background-color: black;
      }

      div.CodeExample p {
        font-family: Consolas;
        margin: 0.5em;
        border-bottom: 1px solid #DDDDDD;
      }

      div.CodeExample div {
        font-family: Consolas;
        margin: 0.5em;
      }

      h4 {
        margin-bottom: 0;
      }

      div.Signature {
        border: 1px solid #C0C0C0;
        background: black;
        padding: 1em;
        font-family: Consolas;
      }
    </style>
  </xsl:template>

  <xsl:template name="create-default-script">
    <script type="text/JavaScript">
      function toggle_display (block) {
        var w = document.getElementById (block);
        var t = document.getElementById (block + ":toggle");
        if (w.style.display == "none") {
          w.style.display = "block";
          t.innerHTML = "⊟";
        } else {
          w.style.display = "none";
          t.innerHTML = "⊞";
        }
      }
    </script>
  </xsl:template>

  <xsl:template name="create-index">
    <xsl:if test="
        count(PageTitle/@id) &gt; 0 and 
        count(Signature/@id) &gt; 0 and
        count(Remarks/@id) &gt; 0 and
        count(Members/@id) &gt; 0
        ">
      <div class="SideBar">
        <p>
          <a>
            <xsl:attribute name="href">
              <xsl:text>#</xsl:text>
              <xsl:value-of select="PageTitle/@id" />
            </xsl:attribute>
            <xsl:text>Overview</xsl:text>
          </a>
        </p>
        <p>
          <a>
            <xsl:attribute name="href">
              <xsl:text>#</xsl:text>
              <xsl:value-of select="Signature/@id" />
            </xsl:attribute>
            <xsl:text>Signature</xsl:text>
          </a>
        </p>
        <p>
          <a>
            <xsl:attribute name="href">
              <xsl:text>#</xsl:text>
              <xsl:value-of select="Remarks/@id" />
            </xsl:attribute>
            <xsl:text>Remarks</xsl:text>
          </a>
        </p>
        <p>
          <a href="#Members">Members</a>
        </p>
        <p>
          <a>
            <xsl:attribute name="href">
              <xsl:text>#</xsl:text>
              <xsl:value-of select="Members/@id" />
            </xsl:attribute>
            <xsl:text>Member Details</xsl:text>
          </a>
        </p>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template name="create-default-collection-title">
    <div class="CollectionTitle">
      <xsl:apply-templates select="CollectionTitle/node()" />
    </div>
  </xsl:template>

  <xsl:template name="create-default-title">
    <h1 class="PageTitle">
      <xsl:if test="count(PageTitle/@id) &gt; 0">
        <xsl:attribute name="id">
          <xsl:value-of select="PageTitle/@id" />
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="PageTitle/node()" />
    </h1>
  </xsl:template>

  <xsl:template name="create-default-summary">
    <p class="Summary">
      <xsl:if test="count(Summary/@id) &gt; 0">
        <xsl:attribute name="id">
          <xsl:value-of select="Summary/@id" />
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="Summary/node()" />
    </p>
  </xsl:template>

  <xsl:template name="create-default-signature">
    <div>
      <xsl:if test="count(Signature/@id) &gt; 0">
        <xsl:attribute name="id">
          <xsl:value-of select="Signature/@id" />
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="Signature/node()" />
    </div>
  </xsl:template>

  <xsl:template name="create-default-remarks">
    <div class="Remarks">
      <xsl:if test="count(Remarks/@id) &gt; 0">
        <xsl:attribute name="id">
          <xsl:value-of select="Remarks/@id" />
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="Remarks/node()" />
    </div>
  </xsl:template>

  <xsl:template name="create-default-members">
    <div class="Members">
      <xsl:if test="count(Members/@id) &gt; 0">
        <xsl:attribute name="id">
          <xsl:value-of select="Members/@id" />
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="Members/node()" />
    </div>
  </xsl:template>

  <xsl:template name="create-default-copyright">
    <div class="Copyright">
      <xsl:apply-templates select="Copyright/node()" />
    </div>
  </xsl:template>
</xsl:stylesheet>

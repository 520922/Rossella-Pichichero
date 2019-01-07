<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.w3.org/1999/xhtml">

    <xsl:output method="html" indent="yes" omit-xml-declaration="yes"/>
  
    <!-- ******************************** Applicare Template per tutto TEI ******************************** -->  
    <!--Selezione tutti elementi-->
    <xsl:template match="tei:TEI">
        <html>
            <head>                
                <link href="main.css" rel="stylesheet" type="text/css"/>              
                <title>Barone Rampante</title>
            </head>
            <body>              
                <div id="wrapper">
                    <div id="main">
                       <xsl:apply-templates select="tei:text"/>                        
                    </div>   
                    <div id="sidebar">
                        <xsl:apply-templates select="tei:teiHeader"/> 
                    </div>                    
                </div>
            </body>
        </html>
    </xsl:template>

    <!-- ******************************** M A I N    W R A P P E R ******************************** -->
    <xsl:template match="tei:text" >
        <div class="inner">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!--Header -->
    <xsl:template match="tei:front/tei:titlePage" >
        <div id="header">
            <h1>
                <xsl:apply-templates/>
            </h1>
        </div>
    </xsl:template>
    
    <!--Front -->
    <xsl:template match="tei:front/tei:div">
        <section id="frontDesc">
            <xsl:apply-templates/>
        </section>
    </xsl:template>
    

    
    <!-- All Chapters    -->
    <xsl:template match="tei:body">        
        <xsl:for-each select="tei:div">
            <section>
                <xsl:apply-templates/>          
            </section>
        </xsl:for-each>        
    </xsl:template>
    
    

    <!-- ******************************** S I D E  B A R ******************************** -->
    <xsl:template match="tei:teiHeader">
        <!--reordering HTML DOM Nodes-->
        <div class="inner">
            <section>
                <xsl:apply-templates select="tei:encodingDesc"/>
            </section>
            <nav id="menu">
                <xsl:apply-templates select="tei:fileDesc/tei:sourceDesc"/>
            </nav>
        </div>       
    </xsl:template>
    
    <!--Info Box-->    
    <xsl:template match="tei:encodingDesc">
        <header class="major">
            <h2>Il Progetto</h2>
        </header>
        <div class="service-1 click1">
            <div class="row">
                <input type="checkbox" id="expend" />
                <div class="medium-12 small-12 columns smalldesc">
                    <xsl:apply-templates/>
                </div>
                <label for="expend">Leggi Tutto</label>
            </div>
        </div>
    </xsl:template>
    
    <!--Menu-->
    <xsl:template match="tei:sourceDesc">
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    
    <!-- Order section-->
    <xsl:template match="tei:bibl">  

        <!-- Lists -->
        <li>
            <span class="opener extra">Persone</span>
            <ul id="menuPersone">
                <xsl:for-each select="distinct-values(//tei:name[@type='persona'])">
                    <xsl:sort select="."/>
                    <li class="menuPersone"><xsl:value-of select="."/></li>
                </xsl:for-each> 
            </ul>
        </li>
        
        <li>
            <span class="opener extra">Luoghi</span>
            <ul id="menuLuogo">               
                <xsl:for-each select="distinct-values(//tei:name[@type='luogo'])">
                    <xsl:sort select="."/>
                    <li class="menuLuogo"><xsl:value-of select="."/></li>
                </xsl:for-each>                
            </ul>
        </li>
        <li>
            <span class="opener extra">PAROLE STRANIERE</span>
            <ul id="linguestraniere">               
                <xsl:for-each select="distinct-values(//tei:foreign)">
                    <xsl:sort select="."/>
                    <li class="menuLuogo"><xsl:value-of select="."/></li>
                </xsl:for-each>                
            </ul>
        </li>      
        <li>
            <span class="opener extra"> Titoli Nobiliari</span>
            <ul id="menuLuogo">               
                <xsl:for-each select="distinct-values(//tei:roleName[@type='nobile'])">
                    <xsl:sort select="."/>
                    <li class="menuLuogo"><xsl:value-of select="."/></li>
                </xsl:for-each>                
            </ul>
        </li>                
                
        <hr></hr>
        <!-- DESC -->
        <li>
            <span class="opener" >Bibliografia</span>
            <ul>
                <li><b>Titolo: </b> <xsl:value-of select="tei:title"/></li>
                <li><b>Autore: </b> <xsl:value-of select="tei:author"/></li>
                <li><b>Pubblicatore: </b> <xsl:value-of select="tei:publisher"/></li>
                <li><b>Anno: </b> <xsl:value-of select="tei:date"/></li>
            </ul>
        </li>
        
        <li>
            <span class="opener" id="ttt">Dettaglio di Codifica</span>
            <ul>                
                <li><b>Codificatore: </b> Rossella Pichichero</li>
                <li><b>Schema: </b> TEI-Lite P5 DTD </li>
                <li><b>Matricola: </b> 520922 </li>                
                <li><b>Anno: </b> 2018</li>                
            </ul>
        </li>       
    </xsl:template>
    
 
    
    <!-- ******************************** G L O B A L E ******************************** -->
    
    <!-- Figures -->
    <xsl:template match="//tei:figure">
        <span class="image main">
            <img>
                <xsl:attribute name="src">
                    <xsl:value-of select="tei:graphic/@url"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                    <xsl:value-of select="tei:figDesc"/>
                </xsl:attribute>
            </img>            
        </span>
    </xsl:template>
    
    <!-- Names -->    
    <xsl:template match="tei:name">     
        <span class="tuttiNomi" >           
            <xsl:value-of select="."/>
        </span>
    </xsl:template>

    <!-- Numbers -->    
    <xsl:template match="tei:num">     
        <span class="tuttiNumeri" >           
            <xsl:value-of select="."/>
        </span>
    </xsl:template>
    
    <!-- Dates -->    
    <xsl:template match="tei:date">     
        <span class="tuttiDati" >           
            <xsl:value-of select="."/>
        </span>
    </xsl:template>

    <!-- Headers -->
    <xsl:template match="tei:head">
        <xsl:choose>
            <xsl:when test="@rend='frontHead'">
                <header class="main">
                    <h2>
                        <xsl:apply-templates/>
                    </h2>
                </header>
            </xsl:when>
            <xsl:otherwise>
                <h2>
                    <xsl:apply-templates/>
                </h2>
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:template>
    
    <!-- P tags -->
    <xsl:template match="tei:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    
</xsl:stylesheet>



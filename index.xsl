<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8" indent="yes" doctype-system="about:legacy-compat" />

	<xsl:template match="/">
		<html>
			<head>
				<title>
					<xsl:value-of select="site/title"/>
				</title>
				<link rel="stylesheet" href="./stylesheets/style.css" />
				<script src="./js/jquery-1.9.1.min.js"></script>
				<script src="./js/smooth_page_scrolling.js"></script>
				<script src="./js/left_menu_fix.js"></script>
				<script src="./js/portfolio-slider.js"></script>
				<script src="./js/portfolio-filters.js"></script>
				<script src="./js/scripts.js"></script>	
			</head>
			<body>
				<div class="l-wrap">
					<div class="l-menu">
						<div class="menu">														
							<xsl:apply-templates select="/site/myphoto" mode="myphoto" />							
							<xsl:apply-templates select="/site/myinfo" mode="myinfo" />																											
							<xsl:apply-templates select="/site/navigation" mode="navigation" />							
						</div>
					</div>
					<div class="l-content">
						<h1 class="title">
							
							<xsl:apply-templates select="/site/title" mode="main_title" />
						</h1>																	
						<xsl:apply-templates select="/site/navigation" mode="content" />
					</div>
				</div>
				<div class="l-footer">
					<xsl:apply-templates select="/site/footer" mode="footer" />					
				</div>
			</body>
		</html>
	</xsl:template>					
	<xsl:template match="*" mode="myinfo">		
		<div class="myinfo">
			<xsl:for-each select="*">
				<div>
					<xsl:attribute name="class">
						<xsl:value-of select="name()"/>
					</xsl:attribute>
					<xsl:value-of select="."/>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>		
	<xsl:template match="*" mode="myphoto">
		<div>
			<xsl:attribute name="class">
				<xsl:value-of select="name()"/>
			</xsl:attribute>
			<xsl:variable name="src" select="./src" />
			<xsl:variable name="alt" select="./alt" />
			<img src="{$src}" alt="{$alt}" />
		</div>
	</xsl:template>	
	<xsl:template match="title/*" mode="main_title">
		<xsl:copy>
			<xsl:value-of select="."/>
		</xsl:copy>		
	</xsl:template>
	<!-- Main Content Blocks -->	
	<xsl:template match="*" mode="content">
		<xsl:for-each select="item">
			<xsl:variable name="id" select="position()"/>						
			<xsl:choose>
				<xsl:when test="@title_display = 'show'">
					<h2 id="nav{$id}" class=""><xsl:value-of select="@name"/></h2>
				</xsl:when>
				<xsl:when test="@title_display = 'hide'">
					<div id="nav{$id}" class="l-hidden"></div>					
				</xsl:when>
				<xsl:otherwise>
					<h2 id="nav{$id}" class=""><xsl:value-of select="@title_display"/></h2>
				</xsl:otherwise>
			</xsl:choose> 									
			<xsl:apply-templates select="*" mode="content_block" />						
		</xsl:for-each>
	</xsl:template>
	
	<!-- Portfolio -->
	<xsl:template match="portfolio" mode="content_block">
		<!-- Portfolio Viewer -->
		<div class="portfolio_view" id="portfolio_view">
			<div class="img"></div>
			<div class="info"></div>
		</div>
		<!-- Portfolio Filters -->
		<div class="portfolio-filters" id="portfolio-filters">
			<div class="company">
				<h4>Company:</h4>
				<ul>													
					<xsl:for-each select="//portfolio//company/item[not(.=following::item)]">
						<xsl:variable name="item" select="."/>
						<li><span class="count"><xsl:value-of select="count(//portfolio//company[item = $item])"/></span><span class="select"><xsl:value-of select="."/></span></li>
					</xsl:for-each>
				</ul>
			</div>		
			<div class="year">
				<h4>Year:</h4>
				<ul>													
					<xsl:for-each select="//portfolio//year/item[not(.=following::item)]">
						<xsl:variable name="item" select="."/>
						<li><span class="count"><xsl:value-of select="count(//portfolio//year[item = $item])"/></span><span class="select"><xsl:value-of select="."/></span></li>
					</xsl:for-each>
				</ul>
			</div>
			<div class="role">
				<h4>Role:</h4>
				<ul>													
					<xsl:for-each select="//portfolio//role/item[not(.=following::item)]">				
						<xsl:variable name="item" select="."/>
						<li><span class="count"><xsl:value-of select="count(//portfolio//role[item = $item])"/></span><span class="select"><xsl:value-of select="."/></span></li>
					</xsl:for-each>
				</ul>
			</div>
			<div class="tools">
				<h4>Tools:</h4>
				<ul>													
					<xsl:for-each select="//portfolio//tools/item[not(.=following::item)]">
						<xsl:variable name="item" select="."/>
						<li><span class="count"><xsl:value-of select="count(//portfolio//tools[item = $item])"/></span><span class="select"><xsl:value-of select="."/></span></li>
					</xsl:for-each>
				</ul>
			</div>
		</div>
		<!-- Portfolio Viewer -->
		<div class="portfolio_filters_info" id="portfolio_filters_info" style="display:none">
			<span class=""></span>
		</div>
		<!-- Portfolio List -->
		<div class="portfolio">			
			<xsl:for-each select="item">				
				<xsl:variable name="id" select="position()"/>

                <xsl:variable name="screenshot">
                    <xsl:choose>
                        <xsl:when test="screenshot != ''">
                            <xsl:value-of select="screenshot"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="url"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>


				<div class="item" id="portfolio-{$id}" data-screenshot="{$screenshot}">
					<div class="title">
						<h3><xsl:value-of select="title"/></h3>
						<div class="url"><xsl:value-of select="url"/></div>						
						<ul class="year">
							<xsl:for-each select="year/item">
								<li><xsl:value-of select="."/></li>
							</xsl:for-each>
						</ul>
						<ul class="company">
							<xsl:for-each select="company/item">
								<li><xsl:value-of select="."/></li>
							</xsl:for-each>
						</ul>
					</div>
					<div class="info"><span><xsl:value-of select="info"/></span></div>
					<ul class="tools">
						<xsl:for-each select="tools/item">
							<li><xsl:value-of select="."/></li>
						</xsl:for-each>
					</ul>
					<ul class="role">
						<xsl:for-each select="role/item">
							<li><xsl:value-of select="."/></li>
						</xsl:for-each>
					</ul>
				</div>
			</xsl:for-each>
		</div>		
	</xsl:template>

	<xsl:template match="rate" mode="content_block">
		<ul>
			<xsl:attribute name="class">
				<xsl:value-of select="name()"/>
			</xsl:attribute>
			<!-- Rates with Stars -->
			<xsl:for-each select="item">
				<xsl:variable name="i" select="@rate"/>
				<li>
					<span class="title"><xsl:value-of select="@title"/></span>
					<span class="rate{$i}"></span>
				</li>								
			</xsl:for-each>
		</ul>
		<div class="skills">
			<!-- Skills with descriptions -->
			<xsl:for-each select="item">
				<xsl:variable name="title" select="@title"/>
				<p>
					<strong><xsl:value-of select="@title"/></strong>
					<xsl:value-of select="."/>
				</p>								
			</xsl:for-each>
		</div>					
	</xsl:template>

	<!-- Social Buttons -->
	<xsl:template match="soc" mode="content_block">
		<ul>
			<xsl:variable name="class" select="name()"/>
			<xsl:attribute name="class">
				<xsl:value-of select="$class"/>
			</xsl:attribute>
			<xsl:for-each select="link">
				<xsl:variable name="i" select="position()"/>
				<li class="soc_{$i}">
					<a>
						<xsl:attribute name="href">
							<xsl:value-of select="."/>
						</xsl:attribute>						
					</a>
				</li>
			</xsl:for-each>			
		</ul>
	</xsl:template>
	<!-- General Information -->
	<xsl:template match="me" mode="content_block">
		<ul>
			<xsl:attribute name="class">
				<xsl:value-of select="name()"/>
			</xsl:attribute>
			<xsl:for-each select="item">
				<li>
					<span><xsl:value-of select="@title"/></span> 
					<xsl:value-of select="."/>
				</li>
			</xsl:for-each>		
		</ul>
	</xsl:template>
	<!-- Equipment -->
	<xsl:template match="equipment" mode="content_block">
		<ul class="i-equipment">		
		<xsl:for-each select="item">
			<li><span><xsl:value-of select="@title"/></span><xsl:value-of select="."/></li>
		</xsl:for-each>
		</ul>
	</xsl:template>
	<!-- Experience -->
	<xsl:template match="experience" mode="content_block">
		<div>
			<xsl:attribute name="class">
				<xsl:value-of select="name()"/>
			</xsl:attribute>
		<xsl:for-each select="item">
			<div>
				<xsl:attribute name="class">
					<xsl:value-of select="name()"/>
				</xsl:attribute>
				<h3><xsl:value-of select="./company"/></h3>
                <xsl:variable name="logo" select="./logo" />
				<div class="img"><img src="./img/company/{logo}" alt="" /></div>
				<ul class="title">
					<xsl:for-each select="title/*">
						<xsl:variable name="class" select="name()"/>
						<li class="{$class}">
							<xsl:value-of select="."/>
						</li>
					</xsl:for-each>
				</ul>
				<div class="description">
					<xsl:apply-templates select="./description/*" mode="content_block_tags" />
				</div>
			</div>
		</xsl:for-each>	
		</div>			
	</xsl:template>
	<!-- Simple Content Block -->
	<xsl:template match="content" mode="content_block">		
		<div>
			<xsl:attribute name="class">
				<xsl:value-of select="@class"/>
			</xsl:attribute>
			<xsl:apply-templates select="*" mode="content_block_tags" />
		</div>
	</xsl:template>	
	<!-- Leave Tags -->
	<xsl:template match="*" mode="content_block_tags">
		<xsl:copy>
			<xsl:value-of select="."/>
		</xsl:copy>
	</xsl:template>
	<!-- Navigation -->
	<xsl:template match="*" mode="navigation">
		<ul>
			<xsl:attribute name="class">				
				<xsl:value-of select="name()"/>
			</xsl:attribute>			
			<xsl:for-each select="*">
				<xsl:variable name="id" select="position()"/>
				<li><a href="#nav{$id}"><xsl:value-of select="@name"/></a></li>
			</xsl:for-each>
		</ul>
	</xsl:template>	
	<xsl:template match="site/footer" mode="footer">
		<div class="copyright"><xsl:value-of select="."/></div>
	</xsl:template>
</xsl:stylesheet>
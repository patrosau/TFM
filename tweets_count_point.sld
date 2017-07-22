<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>tweets_count</Name>
    <UserStyle>
      <Title>tweets_count</Title>
      <FeatureTypeStyle>
	<Rule>
      <Name> #Tweets = 1</Name>
	  <ogc:Filter>
	    <ogc:PropertyIsEqualTo>
	      <ogc:PropertyName>tweets_count</ogc:PropertyName>
	      <ogc:Literal>1</ogc:Literal>
	    </ogc:PropertyIsEqualTo>
	  </ogc:Filter>
	  <PointSymbolizer>
	    <Graphic>
	      <Mark>
		<WellKnownName>square</WellKnownName>
		<Fill>
		  <CssParameter name="fill">#0000FF</CssParameter>
		</Fill>
	      </Mark>
	      <Size>4</Size>
	    </Graphic>
	  </PointSymbolizer>
	</Rule>
	<Rule>
      <Name> #Tweets = 2</Name>
	  <ogc:Filter>
	    <ogc:PropertyIsEqualTo>
	      <ogc:PropertyName>tweets_count</ogc:PropertyName>
	      <ogc:Literal>2</ogc:Literal>
	    </ogc:PropertyIsEqualTo>
	  </ogc:Filter>
	  <PointSymbolizer>
	    <Graphic>
	      <Mark>
		<WellKnownName>square</WellKnownName>
		<Fill>
		  <CssParameter name="fill">#0071FF</CssParameter>
		</Fill>
	      </Mark>
	      <Size>4</Size>
	    </Graphic>
	  </PointSymbolizer>
	</Rule>
	<Rule>
      <Name> #Tweets = 3</Name>
	  <ogc:Filter>
	    <ogc:PropertyIsEqualTo>
	      <ogc:PropertyName>tweets_count</ogc:PropertyName>
	      <ogc:Literal>3</ogc:Literal>
	    </ogc:PropertyIsEqualTo>
	  </ogc:Filter>
	  <PointSymbolizer>
	    <Graphic>
	      <Mark>
		<WellKnownName>square</WellKnownName>
		<Fill>
		  <CssParameter name="fill">#00E2FF</CssParameter>
		</Fill>
	      </Mark>
	      <Size>4</Size>
	    </Graphic>
	  </PointSymbolizer>
	</Rule>
	<Rule>
      <Name> #Tweets = 4</Name>
	  <ogc:Filter>
	    <ogc:PropertyIsEqualTo>
	      <ogc:PropertyName>tweets_count</ogc:PropertyName>
	      <ogc:Literal>4</ogc:Literal>
	    </ogc:PropertyIsEqualTo>
	  </ogc:Filter>
	  <PointSymbolizer>
	    <Graphic>
	      <Mark>
		<WellKnownName>square</WellKnownName>
		<Fill>
		  <CssParameter name="fill">#00FFA9</CssParameter>
		</Fill>
	      </Mark>
	      <Size>4</Size>
	    </Graphic>
	  </PointSymbolizer>
	</Rule>
	<Rule>
      <Name> #Tweets = 5</Name>
	  <ogc:Filter>
	    <ogc:PropertyIsEqualTo>
	      <ogc:PropertyName>tweets_count</ogc:PropertyName>
	      <ogc:Literal>5</ogc:Literal>
	    </ogc:PropertyIsEqualTo>
	  </ogc:Filter>
	  <PointSymbolizer>
	    <Graphic>
	      <Mark>
		<WellKnownName>square</WellKnownName>
		<Fill>
		  <CssParameter name="fill">#00FF38</CssParameter>
		</Fill>
	      </Mark>
	      <Size>4</Size>
	    </Graphic>
	  </PointSymbolizer>
	</Rule>
	<Rule>
      <Name> #Tweets = 6</Name>
	  <ogc:Filter>
	    <ogc:PropertyIsEqualTo>
	      <ogc:PropertyName>tweets_count</ogc:PropertyName>
	      <ogc:Literal>6</ogc:Literal>
	    </ogc:PropertyIsEqualTo>
	  </ogc:Filter>
	  <PointSymbolizer>
	    <Graphic>
	      <Mark>
		<WellKnownName>square</WellKnownName>
		<Fill>
		  <CssParameter name="fill">#38FF00</CssParameter>
		</Fill>
	      </Mark>
	      <Size>4</Size>
	    </Graphic>
	  </PointSymbolizer>
	</Rule>
	<Rule>
      <Name> #Tweets = 7</Name>
	  <ogc:Filter>
	    <ogc:PropertyIsEqualTo>
	      <ogc:PropertyName>tweets_count</ogc:PropertyName>
	      <ogc:Literal>7</ogc:Literal>
	    </ogc:PropertyIsEqualTo>
	  </ogc:Filter>
	  <PointSymbolizer>
	    <Graphic>
	      <Mark>
		<WellKnownName>square</WellKnownName>
		<Fill>
		  <CssParameter name="fill">#AAFF00</CssParameter>
		</Fill>
	      </Mark>
	      <Size>4</Size>
	    </Graphic>
	  </PointSymbolizer>
	</Rule>
	<Rule>
      <Name> #Tweets = 8</Name>
	  <ogc:Filter>
	    <ogc:PropertyIsEqualTo>
	      <ogc:PropertyName>tweets_count</ogc:PropertyName>
	      <ogc:Literal>8</ogc:Literal>
	    </ogc:PropertyIsEqualTo>
	  </ogc:Filter>
	  <PointSymbolizer>
	    <Graphic>
	      <Mark>
		<WellKnownName>square</WellKnownName>
		<Fill>
		  <CssParameter name="fill">#FFE200</CssParameter>
		</Fill>
	      </Mark>
	      <Size>4</Size>
	    </Graphic>
	  </PointSymbolizer>
	</Rule>
	<Rule>
      <Name> #Tweets = 9</Name>
	  <ogc:Filter>
	    <ogc:PropertyIsEqualTo>
	      <ogc:PropertyName>tweets_count</ogc:PropertyName>
	      <ogc:Literal>9</ogc:Literal>
	    </ogc:PropertyIsEqualTo>
	  </ogc:Filter>
	  <PointSymbolizer>
	    <Graphic>
	      <Mark>
		<WellKnownName>square</WellKnownName>
		<Fill>
		  <CssParameter name="fill">#FF7100</CssParameter>
		</Fill>
	      </Mark>
	      <Size>4</Size>
	    </Graphic>
	  </PointSymbolizer>
	</Rule>
	<Rule>
      <Name> #Tweets > 10</Name>
	  <ogc:Filter>
	    <ogc:PropertyIsGreaterThan>
	      <ogc:PropertyName>tweets_count</ogc:PropertyName>
	      <ogc:Literal>10</ogc:Literal>
	    </ogc:PropertyIsGreaterThan>
	  </ogc:Filter>
	  <PointSymbolizer>
	    <Graphic>
	      <Mark>
		<WellKnownName>square</WellKnownName>
		<Fill>
		  <CssParameter name="fill">#FF0000</CssParameter>
		</Fill>
	      </Mark>
	      <Size>4</Size>
	    </Graphic>
	  </PointSymbolizer>
	</Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>


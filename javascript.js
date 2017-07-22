(function(){
    
    /**
 	* Define a namespace for the application.
 	*/
	window.app = {};
	var app = window.app;
	
	var selectedTimeGranularity = 'Daily';
	var minDate = new Date(2017, 01,19);	//19-01-2017
  	var maxDate = new Date(2017, 02,10);	//10-03-017
	var selectedDate = new Date(2017, 01,27); // 27-2-2017
	var hour = 0;
	var hourlyRb = CreateRadioButton("Granularity", "Hourly");
	var dailyRb = CreateRadioButton("Granularity", "Daily");
	var datepicker = CreateDatePicker();
	var hourlabel = CreateLabel(getHourString(hour));
	    
	
	/**
	* @constructor
	* @extends {ol.control.Control}
	* @param {Object=} opt_options Control options.
	*/
	app.CustomToolbarControl = function(opt_options) {

  		var options = opt_options || {};

		var element = document.createElement('div');
		element.className = 'ol-unselectable ol-mycontrol container-fluid';
		hourlyRb.onclick = function() {onGranularityChanged();};
		dailyRb.onclick = function() {onGranularityChanged();};
		element.appendChild(hourlyRb);
		element.appendChild(CreateLabel("Hourly"));
		element.appendChild(dailyRb);
		element.appendChild(CreateLabel("Daily"));
		
		var dateTimeControls = document.createElement('div');
	    dateTimeControls.setAttribute("class","dateTimeControls");
	    var minusButton = CreateButton('-');
	    minusButton.onclick = function(e){
	    	if (dailyRb.checked)
	    	{
  				selectedDate = addDays(selectedDate, -1);
  			}
  			else
  			{
  				if (hour > 1)
  				{
  					hour = hour - 1;
  				}
  				else
  				{
  					hour = 23;
  					selectedDate = addDays(selectedDate, -1);
  				}
  			}
  			
  			hourlabel.innerHTML = getHourString(hour);
  			datepicker.value = selectedDate.toCustomString();
  			loadWMS_ServerTiledLayer();
  		}
	    dateTimeControls.appendChild(minusButton);
	    datepicker.value = selectedDate.toCustomString();
	    datepicker.min = minDate.toCustomString();
	    datepicker.max = maxDate.toCustomString();
	    dateTimeControls.appendChild(datepicker);
	    
	    hourlabel.style.display = 'none';
	    hourlabel.style.margin = '5px';
	    dateTimeControls.appendChild(hourlabel);
	    
	    var plusButton = CreateButton('+');
	    plusButton.onclick = function(e){
	    	if (dailyRb.checked)
	    	{
  				selectedDate = addDays(selectedDate, 1);
  			}else
  			{
  				if (hour < 23)
  				{
  					hour = hour + 1;
  				}
  				else
  				{
  					hour = 0;
  					selectedDate = addDays(selectedDate, 1);
  				}
  			}
  			
  			hourlabel.innerHTML = getHourString(hour);
  			datepicker.value = selectedDate.toCustomString();
  			loadWMS_ServerTiledLayer();
  		}
	    dateTimeControls.appendChild(plusButton);
	    
		element.appendChild(dateTimeControls);
		//addLegendItemControls(element);
		element.appendChild(CreateLegendPanel());
		
		dailyRb.checked = true;

	  ol.control.Control.call(this, {
		element: element,
		target: options.target
	  });

	};
	ol.inherits(app.CustomToolbarControl, ol.control.Control);
	
	function onGranularityChanged() {
		if (dailyRb.checked)
		{
			hourlabel.style.display = 'none';
		}
		else
		{
			hourlabel.style.display = 'inline';
		}
		loadWMS_ServerTiledLayer();
	}
	
	function getHourString(hour){
		return hour.toString() + ":00 - " + hour.toString() + ":59";
	}
	
	function addDays(date, days) {
    	var result = new Date(date);
    	result.setDate(result.getDate() + days);
    	return result;
	}
	
	String.prototype.toDate = function()
	{
		if (this.includes('-'))
		{
			[year, month, day] = this.split('-')
			return new Date(year, month -1, day);
		}
		else
		{
			return new Date(this.substring(0,4), parseInt(this.substring(4,6)) - 1, this.substring(6,9));
		}
	}
	
	Date.prototype.yyyymmdd = function() {
  		var mm = this.getMonth() + 1; // getMonth() is zero-based
  		var dd = this.getDate();

  		return [this.getFullYear(),
          (mm>9 ? '' : '0') + mm,
          (dd>9 ? '' : '0') + dd
         ].join('');
	};
	
	Date.prototype.toCustomString = function()
	{
		var mm = this.getMonth() + 1; // getMonth() is zero-based
  		var dd = this.getDate();

  		return [this.getFullYear(),
          (mm>9 ? '' : '0') + mm,
          (dd>9 ? '' : '0') + dd
         ].join('-');
	}
	
	function CreateSelectControl(elements)
	{
		var combo = document.createElement("select");
		for(var i = 0; i < elements.length; i++)
		{
			var option = document.createElement("option");
			option.value = elements[i];
			option.text = elements[i];
			combo.appendChild(option);
		}
		
		return combo;
	}
	
	function CreateButton(text)
	{
		var button = document.createElement('button');
		
		button.setAttribute("class","btn btn-primary btn-sm");
  		button.innerHTML = text;
  		return button;
	}
	
	function CreateRadioButton(group, value)
	{
		var radio = document.createElement("input");
		radio.type = "radio";
    	radio.name = group;
    	radio.value = value;
    	
    	return radio;
	}
	
	function CreateLabel(text)
	{
		var label = document.createElement("label");
		label.innerHTML = text;
		
		return label;
	}
	
	function CreateLegendPanelBackup()
	{
		var legendPanel = document.createElement('div');
		legendPanel.setAttribute("data-role","collapsible");
		
		legendPanel.innerHTML = "<h1>Click me - I'm collapsible!</h1><p><img src=\"http://localhost:8080/geoserver/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=20&HEIGHT=20&LAYER=twitter:countershour&STYLE=tweets_count\"/></p>";
		
		return legendPanel;
	}
	
	function CreateLegendPanel()
	{
		var legendPanel = document.createElement('div');
		
		var button = document.createElement("button");
		button.setAttribute("class","btn btn-primary btn-sm");
		button.innerHTML = "Legend +";
		button.onclick = function(){
        	this.classList.toggle("active");
        	var panel = this.nextElementSibling;
        	if (panel.style.display === "block") {
            	panel.style.display = "none";
        	} else {
            	panel.style.display = "block";
        	}
        }
		
		var panel = document.createElement("div");
		panel.setAttribute("class","panel");
		panel.appendChild(getLegendImage());
		
		legendPanel.appendChild(button);
		legendPanel.appendChild(panel);
		
		return legendPanel;
	}
	
	function getLegendImage()
	{
		var img = document.createElement("img");
		img.src = "http://localhost:8080/geoserver/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=20&HEIGHT=20&LAYER=twitter:countershour&STYLE=tweets_count";
		
		return img;
	}
	
	function CreateDatePicker()
	{
		var datePicker = document.createElement("input");
		datePicker.setAttribute("type", "date");
    	datePicker.onchange = function(e)
    	{
    		selectedDate = datePicker.value.toDate();
    		loadWMS_ServerTiledLayer();
    	}	
    	return datePicker;
	}
	
	var projectionSphericalMercator = 'EPSG:3857';
	var tileGridSize = 256;

	var projExtent = ol.proj.get(projectionSphericalMercator).getExtent();
    var startResolution = ol.extent.getWidth(projExtent) / tileGridSize;
    var resolutions = new Array(20);
    for (var i = 0, ii = resolutions.length; i < ii; ++i) {
        resolutions[i] = startResolution / Math.pow(2, i);
    }
	
	
      var layers = [
	  	new ol.layer.Tile({
	  	source:
	  	new ol.source.XYZ({url: 'http://{a-c}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png'})})];
	  	
      var map = new ol.Map({
        projection: projectionSphericalMercator,
        displayProjection: projectionSphericalMercator,
        units: 'meters',
      	controls: ol.control.defaults({
    		attributionOptions: /** @type {olx.control.AttributionOptions} */ ({
      		collapsible: false
    	})
  		}).extend([
    	new app.CustomToolbarControl()
  		]),
        layers: layers,
        target: 'map',
        view: new ol.View({
          center: [-2107000, 4569099],
          zoom: 2
        })
      });
      
      //center: [-10997000, 4569099],
      
	var loadedLayers = [];
    function findLayer(layerId) {
        console.log('findLayer');
        return loadedLayers.find(function (e) {
            return e.layerId == layerId;
        });
    }
    function getLayer(layerId) {
        console.log('getLayer');
        var cached = findLayer(layerId);
        if (cached) return cached.layer;
        return undefined;
    }
    function saveLayer(layer, layerId, layerPriority) {
        console.log('saveLayer: layer: ' + layer);
        loadedLayers.push({
            layerId: layerId,
            layer: layer,
            layerPriority: layerPriority,
        });
    }
    function removeLayer(layerId) {
        var vector = getLayer(layerId);
        if (vector) {
        	map.removeLayer(vector);
        }
        loadedLayers = loadedLayers.filter(function (e) {
            return e.layerId != layerId;
        });       
    }
    function redrawLayers() {
        console.log('redrawLayers. START');
        loadedLayers.sort(function (a, b) { return a.layerPriority - b.layerPriority; });
        for (var i = 0; i < loadedLayers.length; i++) {
            var cached = loadedLayers[i];
            map.removeLayer(cached.layer);
            map.addLayer(cached.layer);
        }
        console.log('redrawLayers. END');
    }
    
    /**
       * Renders a progress bar.
       * @param {Element} el The target element.
       * @constructor
       */
    function Progress(el) {
        this.el = el;
        this.loading = 0;
        this.loaded = 0;
        this.requestId = 0;
    }

    Progress.prototype.Start = function()
    {
        this.loading = 0;
        this.loaded = 0;
        if (this.requestId < 100) {
            this.requestId++;
        } else
        {
            this.requestId = 0;
        }
        previousWidth = 0;
        lastNotifiedProgress = 0;

        this.hide();

        return this.requestId;
    }

    /**
     * Increment the count of loading tiles.
     */
    Progress.prototype.addLoading = function (requestId) {
        if (this.loading === 0) {
            this.show();
        }

        if (this.requestId === requestId) {
            ++this.loading;
            this.update();
        }
    };


    /**
     * Increment the count of loaded tiles.
     */
    Progress.prototype.addLoaded = function (requestId) {
        var this_ = this;
        setTimeout(function () {
            if (this_.requestId === requestId) {
                ++this_.loaded;
                this_.update();
            }
        }, 100);
    };

    var previousWidth = 0;
    var lastNotifiedProgress = 0;
    /**
     * Update the progress bar.
     */
    Progress.prototype.update = function () {
        var width = (this.loaded / this.loading * 100);
        if (previousWidth < width)
        {
            if (width - lastNotifiedProgress > 10)
            {
                lastNotifiedProgress = width;
            }

            previousWidth = width;
            this.el.style.width = width.toFixed(1) + '%';
        }
        
        if (this.loading === this.loaded) {
            this.clear();
        }
    };

    Progress.prototype.clear = function () {
        this.loading = 0;
        this.loaded = 0;
        previousWidth = 0;
        lastNotifiedProgress = 0;
        var this_ = this;
        setTimeout(function () {
            this_.hide();
        }, 500);
    };

    /**
     * Show the progress bar.
     */
    Progress.prototype.show = function () {
        this.el.style.visibility = 'visible';
    };


    /**
     * Hide the progress bar.
     */
    Progress.prototype.hide = function () {
        if (this.loading === this.loaded) {
            this.el.style.visibility = 'hidden';
            this.el.style.width = 0;
        }
    };

    var progress = new Progress(document.getElementById('progress'));

    function loadWMS_ServerTiledLayer()
    {
    	removeLayer(1);
    	removeLayer(2);
        
    	var requestId = progress.Start();

    	loadWMS_ServerTiledLayerStyled(1, requestId, 'tweets_count_point', 13,0);
    	loadWMS_ServerTiledLayerStyled(2, requestId,'tweets_count', 25, 13);
    	
    	redrawLayers();
    }
    
    function loadWMS_ServerTiledLayerStyled(layerId, requestId, style, maxZoom, minZoom)
    {
        console.log('loadWMS_ServerTiledLayer');
        
        var layerPriority = 1;

		
        try {
        
        	var extent = map.getView().calculateExtent(map.getSize());

            var tileGrid = new ol.tilegrid.TileGrid({ resolutions: resolutions, origin: ol.extent.getTopLeft(projExtent), tileSize: tileGridSize });


            var source = new ol.source.TileWMS({
                    url: 'http://localhost:8080/geoserver/twitter/wms',
            		params: {'LAYERS': getLayerName(), 
		     		'TILED': true,
		     		'STYLES': style,
		     		'CQL_FILTER': getCQL_Filter()},
            		serverType: 'geoserver',
                    tileGrid: tileGrid,
                    extent: extent
                });

            var vector = new ol.layer.Tile({
                source: source,
            	opacity: 0.6,
                minResolution: resolutions[maxZoom],
                maxResolution: resolutions[minZoom]
            });
            
            vector.getSource().on('tileloadstart', function () {
                progress.addLoading(requestId);
            });

            vector.getSource().on('tileloadend', function () {
                progress.addLoaded(requestId);
            });

            vector.getSource().on('tileloaderror', function () {
                progress.addLoaded(requestId);
            });

            saveLayer(vector, layerId, layerPriority);
            
            
        }
        catch (exception) {
            manageException(exception, "Error loading server layer.");
        }
    }
    
    function getLayerName()
    {
    	if (dailyRb.checked)
    	{
    		return 'twitter:countersday';
    	}
    	else
    	{
    		return 'twitter:countershour';
    	}
    }
    
    function getCQL_Filter()
    {
    	if (dailyRb.checked)
    	{
    		return 'dayslot = ' + selectedDate.yyyymmdd();
    	}
    	else
    	{
    		return 'hourslot = ' + selectedDate.yyyymmdd() + getHourslot();
    	}
    }
    
    function getHourslot()
    {
    	if (hour < 10)
    	{
    		return '0' + hour.toString();
    	}
    	else
    	{
    		return hour.toString();
    	}
    }

    })();

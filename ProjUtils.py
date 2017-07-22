from osgeo import ogr
from osgeo import osr

class WGS84_WebMercatorConverter:
    def __init__(self):
        source = osr.SpatialReference()
        source.ImportFromEPSG(4326)

        target = osr.SpatialReference()
        target.ImportFromEPSG(3857)
        self.transformation = osr.CoordinateTransformation(source, target)

    def Transform(self, longitude, latitude):
        # create a geometry from coordinates
        point = ogr.Geometry(ogr.wkbPoint)
        point.AddPoint(longitude, latitude)
        point.Transform(self.transformation)
        return [point.GetX(), point.GetY()]
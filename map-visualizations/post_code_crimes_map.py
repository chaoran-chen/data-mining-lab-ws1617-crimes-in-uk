import matplotlib.pyplot as plt
import matplotlib.cm
import pandas as pd
import numpy as np

from mpl_toolkits.basemap import Basemap
from matplotlib.patches import Polygon
from matplotlib.collections import PatchCollection
from matplotlib.colors import Normalize

PATH_TO_POLYGONS = 'Distribution/Areas'
PATH_TO_DATA = 'post_code_crimes.csv'
PATH_TO_OUTPUT_IMAGE = 'post_code_crimes_map.png'


my_data = pd.read_csv(PATH_TO_DATA, header=1)

fig, ax = plt.subplots(figsize=(10,20))
m = Basemap(resolution='f', # c, l, i, h, f or None
            projection='merc',
            lat_0=54.5, lon_0=-4.36,
            llcrnrlon=-11.25, llcrnrlat= 49.77, urcrnrlon=2.68, urcrnrlat=61.39)

m.drawmapboundary(fill_color='#46bcec')
m.fillcontinents(color='#f2f2f2',lake_color='#46bcec')
m.drawcoastlines()

m.readshapefile(PATH_TO_POLYGONS, 'areas')


df_poly = pd.DataFrame({
        'shapes': [Polygon(np.array(shape), True) for shape in m.areas],
        'area': [area['name'] for area in m.areas_info]
    })
df_poly = df_poly.merge(my_data, on='area', how='left')

cmap = plt.get_cmap('Oranges')   
pc = PatchCollection(df_poly.shapes, zorder=2)
norm = Normalize()
 
pc.set_facecolor(cmap(norm(df_poly['count'].fillna(0).values)))
ax.add_collection(pc)

mapper = matplotlib.cm.ScalarMappable(norm=norm, cmap=cmap)
 
mapper.set_array(df_poly['count'])
plt.colorbar(mapper, shrink=0.4)

plt.savefig(PATH_TO_OUTPUT_IMAGE, dpi=600)

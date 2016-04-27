#### Python fast encoding/decoding of google encoded polylines

Just a cython implementation trying to obtain better performances when dealing with _Google_ encoded polylines
(nothing too serious but it works fine, python 2 & 3, written with py3 in mind though).


#### Usage:
__Decoding__
```python
In [1]: from polyline_ggl import decode_polyline

In [2]: decode_polyline("_p~iF~ps|U_ulLnnqC_mqNvxq`@")
Out[2]: [(38.5, -120.2), (40.7, -120.95), (43.252, -126.453)]
```

__Directly decoding with a custom factorization__ (like routes from OSRM)
```python
In [3]: decode_polyline("wthhiAjez|qC[E?oc@?}m@", factor=1e6)
Out[3]: 
[(38.949724, -77.03511),
 (38.949738, -77.035107),
 (38.949738, -77.034523),
 (38.949738, -77.033772)]
```

__Encoding__
```python
In [4]: from polyline_ggl import encode_polyline

In [5]: encode_polyline([(38.5, -120.2), (40.7, -120.95), (43.252, -126.453)])
Out[5]: '_p~iF~ps|U_ulLnnqC_mqNvxq`@'
```

#### Requirements :
  - [Cython](https://pypi.python.org/pypi/Cython/)
  - C compiler

#### Running tests :
```
$ python3 setup.py test
```

#### Installation :
```
$ git clone http://github.com/mthh/polyline_ggl
$ cd polyline_ggl
$ python3 setup.py install
```

#### References :
 - https://developers.google.com/maps/documentation/utilities/polylinealgorithm
 - https://pypi.python.org/pypi/polyline/ (__more than a reference at this point as tests are coming directly from this package__)
 - https://github.com/mapbox/polyline

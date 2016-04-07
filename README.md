#### Fast encoding/decoding of google encoded polylines

Just some tests with cython trying to obtain better performances when dealing with encoded polylines
(nothing serious but it works fine)


#### Usage:
__Decoding__
```python
In [1]: from polyline_ggl import decode_polyline

In [2]: decode_polyline("_p~iF~ps|U_ulLnnqC_mqNvxq`@")
Out[2]: [(38.5, -120.2), (40.7, -120.95), (43.252, -126.453)]
```

__Encoding__
```python
In [3]: from polyline_ggl import encode_polyline

In [4]: encode_polyline([(38.5, -120.2), (40.7, -120.95), (43.252, -126.453)])
Out[4]: '_p~iF~ps|U_ulLnnqC_mqNvxq`@'
```

#### Running tests :
```
$ python3 setup.py test
```

#### Installation
```
$ git clone http://github.com/mthh/polyline_ggl
$ cd polyline_ggl
$ python3 setup.py install
```

#### References :
    - 
    -

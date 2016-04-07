# -*- coding: utf-8 -*-
#cython: boundscheck = False
#cython: wraparound = False
#cython: cdivision = True
from cpython.mem cimport PyMem_Malloc, PyMem_Free

ctypedef int[2] Changes
ctypedef double[2] Point
cdef enum:
    LATITUDE = 0
    LONGITUDE = 1

cpdef decode_polyline(polyline_str):
    assert isinstance(polyline_str, (bytes, str)), \
        "Encoded polyline have to be provided as string/bytes"
    cdef Py_ssize_t len_poly = len(polyline_str)
    cdef unsigned short *encoded_polyline = <unsigned short *>PyMem_Malloc(len_poly * sizeof(unsigned short))
    cdef unsigned int i = 0
    for i in range(len_poly):
        encoded_polyline[i] = <unsigned short>ord(polyline_str[i])
    result = decode(encoded_polyline, len_poly)
    PyMem_Free(encoded_polyline)
    return result

cdef list decode(unsigned short *encoded_polyline, Py_ssize_t len_poly):
    cdef unsigned int shift, result, index = 0
    cdef unsigned short byte
    cdef double lat = 0.0, lng = 0.0
    cdef Changes changes
    cdef list coords = []
    
    while index < len_poly:
        for u in (LATITUDE, LONGITUDE):
            shift, result = 0, 0
            while True:
                byte = encoded_polyline[index] - 63
                result |= (byte & 0x1f) << shift
                index += 1
                shift += 5
                if byte < 0x20:
                    break
            changes[u] = ~(result >> 1) if result & 1 else result >> 1
        lat += changes[LATITUDE]
        lng += changes[LONGITUDE]
        coords.append((lat / 1e5, lng / 1e5))
    return coords
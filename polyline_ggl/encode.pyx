# -*- coding: utf-8 -*-
#cython: boundscheck = False
#cython: wraparound = False
#cython: cdivision = True
from cpython.mem cimport PyMem_Malloc, PyMem_Realloc, PyMem_Free

ctypedef double[2] Point

cdef class MyCharArray:
    cdef unsigned short* data
    cdef unsigned int idx
    def __cinit__(self, size_t number):
        self.data = <unsigned short*> PyMem_Malloc(number * sizeof(unsigned short))
        if not self.data:
            raise MemoryError()
        self.idx = 0
    cdef void *resize(self, size_t new_number):
        mem = <unsigned short*> PyMem_Realloc(self.data, new_number * sizeof(unsigned short))
        if not mem:
            raise MemoryError()
        self.data = mem

    cdef to_string(self):
        return ''.join([chr(self.data[i]) for i in range(self.idx)])

    def __dealloc__(self):
        PyMem_Free(self.data)

cpdef encode_polyline(coordinates):
    assert isinstance(coordinates, (list, tuple)), \
        "Coordinates have to be provided as list/tuple"
    cdef Py_ssize_t len_coords = len(coordinates)
    cdef Point *pts = <Point *>PyMem_Malloc(len_coords * sizeof(Point))
    cdef unsigned int i
    cdef str result

    for i in range(len_coords):
        pts[i][0], pts[i][1] = coordinates[i]
    result = encode(pts, len_coords)
    PyMem_Free(pts)
    return <unicode>result

cdef void *write_enc(MyCharArray output, double coord):
    cdef int pt = <int>round(coord * 1e5)

    pt <<= 1
    pt = pt if pt >= 0 else ~pt
    while pt >= 0x20:
        output.data[output.idx] = (0x20 | (pt & 0x1f)) + 63
        output.idx += 1
        pt >>= 5
    output.data[output.idx] = pt + 63
    output.idx += 1

cdef encode(Point *pts, Py_ssize_t nb_pts):
    cdef unsigned int i = 1
    cdef size_t size_out = 512
    cdef MyCharArray output = MyCharArray(size_out)
    write_enc(output, pts[0][0])
    write_enc(output, pts[0][1])
    for i in range(1, nb_pts):
        if output.idx >= size_out - (size_out / 4):
            size_out += 384
            output.resize(size_out)
        write_enc(output, pts[i][0] - pts[i-1][0])
        write_enc(output, pts[i][1] - pts[i-1][1])
    return output.to_string()

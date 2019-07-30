# -*- coding: utf-8 -*-
from . import decode
from . import encode

decode_polyline = decode.decode_polyline
encode_polyline = encode.encode_polyline

__all__ = ["decode_polyline", "encode_polyline"]

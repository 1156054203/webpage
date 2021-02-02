# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
import collections

temp = loader.get_template('table_template.html')
sunwk = collections.OrderedDict([('id',1),('name','孙悟空'),('phone',1387758),('address','细胞楼1101')])
zhubj = collections.OrderedDict([('id',2),('name','猪八戒'),('phone',1387757),('address','细胞楼1102')])
outlist = [sunwk,zhubj]

# Create your views here.
def testview(request):
    return HttpResponse(temp.render({'customers':outlist}))

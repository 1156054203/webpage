# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html
import json

class DoubanPipeline(object):
    def __init__(self):
        self.file = open('movies.txt', 'w')

    def process_item(self, item, spider):
        #line = json.dumps(dict(item),ensure_ascii=False) + "\n"
        line = dict(item)
        header = '\t'.join(line.keys())
        if self.file.tell() == 0:
            self.file.write(header+'\n')
        values = [x.strip() for x in line.values()]
        value = '\t'.join(values)
        self.file.write(value+'\n')
        return item

    def close_spider(self,spider):  
        self.file.close()

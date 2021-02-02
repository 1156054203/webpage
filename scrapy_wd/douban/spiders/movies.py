# -*- coding: utf-8 -*-
import scrapy
from douban.items import DoubanItem

class MoviesSpider(scrapy.Spider):
    name = 'movies'
    allowed_domains = ['www.douban.com']
    start_urls = ['https://www.douban.com/doulist/240962/']

    def parse(self, response):

        node_list = response.xpath('//*[@class="doulist-item"]')
        totalpage = response.xpath('//span[@class="thispage"]/@data-total-page')[0].extract()
        thispage = response.xpath('//span[@class="thispage"]/text()')[0].extract()

        for node in node_list:
            item = DoubanItem()

            name = node.xpath('div//div[@class="title"]/a/text()').extract()
            if len(name) > 1:
                item['name'] = name[len(name)-1].encode('utf-8') #encode('utf-8')
            elif len(name) == 1:
                item['name'] = node.xpath('div//div[@class="title"]/a/text()')[0].extract().encode('utf-8')
            else:
                continue
            item['score'] = node.xpath('div//div[@class="rating"]/span[2]/text()')[0].extract().encode('utf-8')
            item['num'] = node.xpath('div//div[@class="rating"]/span[3]/text()')[0].extract().encode('utf-8')
            item['actor'] = node.xpath('div//div[@class="abstract"]/text()[2]')[0].extract().encode('utf-8')
            item['type'] = node.xpath('div//div[@class="abstract"]/text()[3]')[0].extract().encode('utf-8')
            item['contory'] = node.xpath('div//div[@class="abstract"]/text()[4]')[0].extract().encode('utf-8')
            item['year'] = node.xpath('div//div[@class="abstract"]/text()[5]')[0].extract().encode('utf-8')

            yield item

        if thispage != totalpage :
            next = response.xpath('//span[@class="thispage"]/following-sibling::a[1]/@href')[0].extract()
            yield scrapy.Request(next,callback = self.parse)
            

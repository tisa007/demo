require 'rubygems'
require 'nokogiri'
require 'open-uri'

class Parser

    def parse(url)
        puts 'parsing url: '+url
        case URI.parse(url).host
        when 'www.360buy.com'
            parse_360buy(url)
        when 'www.amazon.cn'
            parse_amazon(url)
        when 'item.taobao.com'
            parse_taobao(url)
        when 'item.vancl.com'
            parse_vancl(url)
        when 'product.m18.com'
            parse_m18(url)
        end
    end

    def parse_m18(url)
        result = {}
        doc = Nokogiri::HTML(open(url));
        result[:title] = doc.search('title').first.content
        result[:name] = doc.search('h1#styleName').first.content
        result[:price] = doc.search('span#stylePrice').first.content
        result[:image] = doc.search('div#J_zoom img').first['src']
        result
    end
    def parse_vancl(url)
        result = {}
        doc = Nokogiri::HTML(open(url));
        result[:title] = doc.search('title').first.content
        result[:name] = doc.search('h2#productname').first.content
        result[:price] = doc.search('.cuxiaoPrice span').first.content
        result[:image] = doc.search('img#midimg').first['src']
        result
    end
    def parse_taobao(url)
        result = {}
        doc = Nokogiri::HTML(open(url));
        result[:title] = doc.search('title').first.content
        result[:name] = doc.search('input[name=title]').first['value']
        result[:seller] = doc.search('input[name=seller_nickname]').first['value']
        result[:price] = doc.search('input[name=current_price]').first['value']
        result[:image] = doc.search('img#J_ImgBooth').first['src']
        result
    end
    def parse_360buy(url)
        result = {}
        doc = Nokogiri::HTML(open(url));
        result[:title] = doc.search('title').first.content
        result
    end
    def parse_amazon(url)
        result = {}
        doc = Nokogiri::HTML(open(url));
        result[:title] = doc.search('title').first.content
        result[:name] = doc.search('h1.parseasinTitle').first.content
        result[:price] = doc.search('b.priceLarge').first.content
        result[:image] = doc.search('img#prodImage').first['src']
        result
    end
end

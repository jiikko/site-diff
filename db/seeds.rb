site = Site.create(name: 'google', url: 'http://search.yahoo.co.jp/')
site.target_pages.create(path: '/search')
site.target_pages.create(path: '/search;_ylt=A3xT6tTiLkdVbCsArmuJBtF7?p=%E3%83%B4%E3%82%A9%E5%A4%9A&search.x=1&fr=top_ga1_sa&tid=top_ga1_sa&ei=UTF-8&aq=&oq=&afs=')


site = Site.create(name: 'gigazine', url: 'http://gigazine.net/')
site.target_pages.create(path: '/news/20150504-kekkaisensen-machiasobi14/')
site.target_pages.create(path: '/news/20150503-summary-machiasobi14/')
site.target_pages.create(path: '/news/20150504-avex-machiasobi14/')

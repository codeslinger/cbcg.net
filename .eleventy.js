const dayjs = require('dayjs');
const Markdown = require('markdown-it');
const rss = require('@11ty/eleventy-plugin-rss');
const h = require('@11ty/eleventy-plugin-syntaxhighlight');
const brokenLinksPlugin = require("eleventy-plugin-broken-links");

const ROOT_URL = 'https://cbcg.net';

module.exports = function (config) {
    config.addPlugin(h, {});
    config.addPlugin(rss, { posthtmlRenderOptions: { closingSingleTag: 'default' } });
    config.addPlugin(brokenLinksPlugin);

    config.addNunjucksGlobal('all_posts', (local) =>
        local.filter((p) => p.data.title).reverse().map((p) => {
            const content = p.rawInput.replace(/\s*{%\s*endhighlight\s*%}/g, '</code></pre>').replace(/\s*{%\s*highlight\s*.*?%}/g, '<pre><code>');
            return {
                url: p.url,
                inline: false,
                title: p.data.title,
                date: p.date,
                content: content,
                root: ROOT_URL,
                type: 'blog',
                url: p.url,
            };
        }).sort((a, b) => b.date - a.date)
    );

    config.addFilter('public', (posts) => posts.filter((p) => p.data.title));
    config.addFilter('last_updated', (posts) => posts[0].data.date);
    config.addFilter('post_date', (d) => dayjs(d).format('YYYY-MM-DD'));
    config.addFilter('extract_domain', function (url) {
        const u = new URL(url);
        const host = u.hostname;
        return host.startsWith('www.') ? host.substring(4) : host;
    });

    config.addPassthroughCopy('favicon.ico');
    config.addPassthroughCopy('favicon-16x16.png');
    config.addPassthroughCopy('favicon-32x32.png');
    config.addPassthroughCopy('apple-touch-icon.png');
    config.addPassthroughCopy('site.webmanifest');
    config.addPassthroughCopy('android-chrome-192x192.png');
    config.addPassthroughCopy('android-chrome-512x512.png');
    config.addPassthroughCopy('403.html');
    config.addPassthroughCopy('404.html');
    config.addPassthroughCopy('assets');
    config.addPassthroughCopy('talks');

    return {
        dir: {
            input: 'src'
        }
    }
};

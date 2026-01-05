import React from 'react'
import { DocsThemeConfig } from 'nextra-theme-docs'

const config: DocsThemeConfig = {
    logo: (
        <span className="responsive-logo" style={{ fontWeight: 700 }}>
            📊 Data Science Sınav Hazırlık
        </span>
    ),
    head: (
        <>
            <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0" />
            <meta name="apple-mobile-web-app-capable" content="yes" />
            <meta name="theme-color" content="#ffffff" />
        </>
    ),
    project: {
        link: 'https://github.com/NuriOkumus/DataScienceFinal',
    },
    docsRepositoryBase: 'https://github.com/NuriOkumus/DataScienceFinal/tree/main/WebSite',
    footer: {
        text: '☕ Built with Nextra & Coffee | Sınavdan kaçarken yapıldı © 2026',
    },
    useNextSeoProps() {
        return {
            titleTemplate: '%s – Data Science'
        }
    }
}

export default config

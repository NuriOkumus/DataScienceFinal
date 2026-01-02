import React from 'react'
import { DocsThemeConfig } from 'nextra-theme-docs'

const config: DocsThemeConfig = {
    logo: <span style={{ fontSize: '1.25rem', fontWeight: 700 }}>📊 Data Science Sınav Hazırlık</span>,
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

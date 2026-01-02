import React, { useState, useEffect, useRef } from 'react';
import { WebR } from '@r-wasm/webr';

const webR = new WebR() as any;
let initPromise: Promise<void> | null = null;

interface WebRConsoleProps {
    initialCode?: string;
}

export default function WebRConsole({ initialCode = '' }: WebRConsoleProps) {
    const [code, setCode] = useState(initialCode);
    const [output, setOutput] = useState<string[]>([]);
    const [status, setStatus] = useState('Loading R...');
    const [isReady, setIsReady] = useState(false);

    useEffect(() => {
        const startWebR = async () => {
            try {
                if (!initPromise) {
                    initPromise = (async () => {
                        console.log('Initializing WebR...');
                        await webR.init({
                            baseUrl: window.location.origin + '/',
                            serviceWorkerUrl: window.location.origin + '/webr-serviceworker.js',
                            workerUrl: window.location.origin + '/webr-worker.js'
                        });
                        console.log('WebR Initialized. Installing MASS...');
                        await webR.evalR("webr::install('MASS', repos = 'https://repo.r-wasm.org/')");

                        console.log('Installing glmnet (required by mice)...');
                        await webR.evalR("webr::install('glmnet', repos = 'https://repo.r-wasm.org/')");

                        console.log('Installing mice...');
                        await webR.evalR("webr::install('mice', repos = 'https://repo.r-wasm.org/')");

                        console.log('All packages installed successfully.');
                    })();
                }

                await initPromise;
                setStatus('R Ready');
                setIsReady(true);
            } catch (e) {
                console.error('WebR Init Error:', e);
                setStatus(`Error: ${e}`);
                setOutput(prev => [...prev, `System Error: ${e}`]);
            }
        };
        startWebR();
    }, []);

    const runCode = async () => {
        if (!isReady) return;
        setStatus('Running...');
        setOutput([]);

        try {
            await webR.evalR('webr::canvas(width = 500, height = 400)');
            const result = await webR.evalR(code);

            try {
                const out = await result.toJs();
                if (out && out.type !== 'null') {
                    setOutput(prev => [...prev, JSON.stringify(out)]);
                }
            } catch (e) {
                // ignore result parsing error
            }

            setStatus('Done');
        } catch (e: any) {
            setOutput(prev => [...prev, `Error: ${e.message}`]);
            setStatus('Error');
        } finally {
            await webR.evalR('dev.off()');
        }
    };

    return (
        <div style={{ border: '1px solid #444', borderRadius: '8px', padding: '0', margin: '24px 0', background: '#1a1a1a', overflow: 'hidden', boxShadow: '0 4px 6px rgba(0,0,0,0.3)' }}>
            {/* Header */}
            <div style={{ padding: '12px 16px', background: '#252525', borderBottom: '1px solid #444', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <strong style={{ color: '#e0e0e0', fontSize: '14px' }}>Interactive R Console</strong>
                <div style={{ fontSize: '12px', display: 'flex', alignItems: 'center', gap: '6px' }}>
                    <span style={{
                        height: '8px',
                        width: '8px',
                        borderRadius: '50%',
                        background: isReady ? '#4caf50' : '#f44336',
                        display: 'inline-block'
                    }}></span>
                    <span style={{ color: isReady ? '#a5d6a7' : '#ef9a9a' }}>{status}</span>
                </div>
            </div>

            {/* Code Area */}
            <textarea
                value={code}
                onChange={(e) => setCode(e.target.value)}
                style={{
                    width: '100%',
                    minHeight: '300px', // TALLER HEIGHT
                    fontFamily: "'Fira Code', 'Consolas', monospace",
                    fontSize: '14px',
                    lineHeight: '1.5',
                    padding: '16px',
                    backgroundColor: '#1a1a1a',
                    color: '#f8f8f2',
                    border: 'none',
                    outline: 'none',
                    resize: 'vertical'
                }}
                spellCheck={false}
            />

            {/* Toolbar */}
            <div style={{ padding: '12px 16px', borderTop: '1px solid #444', background: '#202020', display: 'flex', justifyContent: 'flex-end' }}>
                <button
                    onClick={runCode}
                    disabled={!isReady}
                    style={{
                        padding: '8px 20px',
                        backgroundColor: isReady ? '#2563eb' : '#4b5563',
                        color: 'white',
                        border: 'none',
                        borderRadius: '6px',
                        cursor: isReady ? 'pointer' : 'not-allowed',
                        fontWeight: '600',
                        fontSize: '13px',
                        transition: 'background 0.2s'
                    }}
                >
                    ▶ Run Code
                </button>
            </div>

            {/* Output Area */}
            {(output.length > 0) && (
                <div style={{ padding: '16px', borderTop: '1px solid #444', background: '#000' }}>
                    <div style={{ fontSize: '12px', color: '#888', marginBottom: '8px', textTransform: 'uppercase', letterSpacing: '1px' }}>Output</div>
                    <pre style={{
                        margin: 0,
                        color: '#ddd',
                        whiteSpace: 'pre-wrap',
                        fontFamily: 'monospace',
                        fontSize: '13px'
                    }}>
                        {output.join('\n')}
                    </pre>
                </div>
            )}

            {/* Hidden Canvas - Placeholder for future implementation */}
            <div style={{ display: 'none' }}>
                <canvas id="webr-canvas" width="500" height="400"></canvas>
            </div>
        </div>
    );
}

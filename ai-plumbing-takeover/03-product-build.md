# 03 — Product Build

This is the buildable spec. Every component is commercially available. Nothing here requires new physics.

## 1. System architecture

```
┌────────────────────────────────────────────────────────────────┐
│                      PipeWhisper System                       │
│                                                                │
│   ┌──────────┐     ┌──────────┐     ┌──────────┐               │
│   │  Node 1  │     │  Node 2  │ ... │ Node N   │               │
│   │ (sensor) │     │ (sensor) │     │ (sensor) │               │
│   └────┬─────┘     └────┬─────┘     └────┬─────┘               │
│        │    LoRa/BLE    │                │                    │
│        └────────┬───────┴────────────────┘                    │
│                 ▼                                             │
│         ┌──────────────┐                                      │
│         │   Gateway    │ ── 4G/Wi-Fi ──┐                      │
│         │ (LoRa hub)   │                │                     │
│         └──────────────┘                ▼                     │
│                               ┌───────────────────┐           │
│                               │  Cloud Backend    │           │
│                               │  - Ingest (Kafka) │           │
│                               │  - ML Inference   │           │
│                               │  - Alert Router   │           │
│                               │  - Fleet Mgmt     │           │
│                               └──────┬─────┬──────┘           │
│                                      │     │                  │
│                       ┌──────────────┘     └──────────────┐   │
│                       ▼                                   ▼   │
│               ┌───────────────┐                 ┌───────────┐ │
│               │ Facility App  │                 │ Plumber   │ │
│               │ (web SaaS)    │                 │ App (iOS) │ │
│               └───────────────┘                 └───────────┘ │
└────────────────────────────────────────────────────────────────┘
```

## 2. The Node — hardware

### 2.1 Component selection (v1 dev kit)

| Component | Part | Unit cost @ 10K | Unit cost @ 100K | Rationale |
|-----------|------|-----------------|------------------|-----------|
| MCU | STM32U585CIU6 (Cortex-M33, TrustZone, ML accel) | $4.80 | $3.20 | Edge ML inference <200mW |
| MEMS mic | Knowles SPH0645LM4H-B | $2.90 | $2.10 | Digital I²S, 24-bit |
| Contact piezo | Murata 7BB-20-6L0 | $3.80 | $2.40 | Wideband structural vibration |
| Pressure sensor (optional v2) | Bosch BMP390 | $2.10 | $1.40 | Ambient + context |
| Radio — LoRa | Semtech SX1262 | $4.50 | $3.00 | 10km line-of-sight |
| Radio — BLE | Nordic nRF52833 | $3.20 | $2.10 | Install / pairing |
| Battery | Tadiran TL-5930 Li-SOCl₂ | $5.10 | $3.80 | 5-year life @ 1% duty cycle |
| PCB 4-layer + passives | Custom | $2.40 | $1.30 | — |
| Enclosure (IP68, ABS+TPE) | Custom mold | $3.80 | $1.80 | Magnetic clamp + strap |
| Pipe clamp / magnet | NdFeB + silicone pad | $2.20 | $1.20 | Fits 0.5" — 6" pipe |
| Assembly + test + QA | CM cost | $3.50 | $1.80 | Contract mfg (China or Mexico) |
| Packaging | Printed box + inserts | $0.80 | $0.40 | — |
| **Node BOM total** | | **$39.10** | **$24.50** | |

At scale, we target a sub-$20 BOM by Year 3 through value engineering (shared radio, custom SoC, in-house mold).

### 2.2 Physical specs

- **Dimensions:** 68mm × 42mm × 24mm
- **Weight:** 78g
- **Mounting:** Dual-mode. Magnetic clamp (steel pipe) OR silicone strap (copper/PEX/PVC).
- **Install time:** <90 seconds per sensor, no tools, no shutdown, no plumber required.
- **Ingress protection:** IP68 (full immersion, dust-tight).
- **Operating range:** -20°C to +85°C.
- **Battery life:** 5 years at 1% duty cycle (30-second acoustic capture every 10 minutes + continuous anomaly monitoring).

### 2.3 Firmware stack

- **RTOS:** Zephyr (Apache 2.0, first-class STM32 support)
- **ML runtime:** TensorFlow Lite for Microcontrollers (TFLM)
- **Model:** 1D-CNN + small transformer head. Quantized int8. ~180KB flash footprint.
- **OTA:** Signed firmware updates delivered via LoRa-FUOTA or BLE fallback.
- **Power management:** Event-driven wake-on-threshold. Uses MCU's low-power peripherals to wake only when a vibration event crosses dynamic baseline.
- **Security:** STM32U5 TrustZone isolation, secure boot, per-device X.509 certs, provisioning via ANS-1 manufacturing station.

### 2.4 On-device ML model

- **Input:** 10-second acoustic window, dual-channel (MEMS + piezo), 16kHz sample rate
- **Feature extraction:** 64-bin Mel spectrogram, 40ms hop
- **Backbone:** 1D depthwise-separable CNN (4 blocks, 24→48→96→128 channels)
- **Classifier:** Light transformer (2 heads, 4 layers) → 12-class output + anomaly score
- **Classes trained:** healthy, corrosion-early, corrosion-advanced, pressure-spike, water-hammer, micro-leak, macro-leak, root-intrusion, frozen-thaw-stress, sediment-load, pump-cavitation, unknown
- **Target performance:** 94% precision / 89% recall at 72-hour failure horizon
- **Retraining cadence:** Monthly cloud retrain, OTA pushed quarterly

## 3. The Gateway

### 3.1 BOM

| Component | Part | Unit cost @ 1K | Unit cost @ 10K |
|-----------|------|----------------|-----------------|
| SoM | Raspberry Pi CM4 2GB/32GB | $55.00 | $48.00 |
| LoRa concentrator | Semtech SX1302 8-channel | $22.00 | $17.50 |
| 4G modem | Quectel EC25 | $18.00 | $14.00 |
| PoE+ input + power mgmt | — | $8.00 | $6.20 |
| Enclosure + mount | Industrial wall-mount | $9.50 | $6.80 |
| Antennas (LoRa + 4G + Wi-Fi) | — | $5.20 | $3.80 |
| Assembly + test | — | $6.00 | $4.00 |
| **Gateway BOM** | | **$123.70** | **$100.30** |

Retail: $399. Gross margin ~69%.

Each gateway handles up to 400 Nodes at 1-minute telemetry cadence, sufficient for a 10-story commercial building with full pipe coverage.

## 4. Cloud backend

### 4.1 Stack

- **Ingest:** AWS IoT Core → Kinesis → Kafka (managed MSK)
- **Storage (cold):** S3 with Parquet / Glacier for long-term acoustic archive
- **Storage (hot):** Amazon Timestream for telemetry, PostgreSQL for metadata
- **ML inference:** SageMaker endpoints for heavy ensemble models, triggered on-device anomaly
- **Feature store:** Tecton or in-house on Feast
- **Event bus:** EventBridge → Lambda for alert routing
- **API:** Go services behind AWS API Gateway, GraphQL for frontend
- **Frontend:** Next.js 14, deployed on Vercel (Year 1-2), moved to ECS once volume demands
- **Mobile:** React Native for plumber app (ship fast, reuse web components)

### 4.2 Data pipeline

```
Node → Gateway → IoT Core → Kafka →
  ├─► Hot path: Kinesis Analytics → Alert Engine → Plumber app
  ├─► Warm path: Lambda → Timestream → Facility dashboard
  └─► Cold path: S3 (Parquet) → SageMaker retrain → Model registry → OTA
```

### 4.3 Alert routing engine (the flywheel)

Single most important service in the stack. When a Node anomaly crosses threshold:

1. **Correlate** with neighboring sensors + historic pressure + building metadata
2. **Classify** severity (P0 <24hr, P1 24-72hr, P2 >72hr, P3 informational)
3. **Route** to nearest certified plumber based on: geography, availability, specialty, rating, capacity
4. **Notify** facility manager in parallel
5. **Track** outcome after the fix — was the prediction right? Feed back into the model
6. **Bill** the 15% referral fee on job completion

This service alone is what turns a sensor company into a platform business.

## 5. Certification & compliance

| Certification | Required? | Cost | Timeline |
|--------------|----------|------|----------|
| FCC Part 15 (radio) | Yes | $22K | 10-14 weeks |
| IC (Canada) | Year 2 | $8K | 6 weeks |
| CE (Europe) | Year 3+ | $30K | 14 weeks |
| UL 94V-0 (flammability) | Yes | $6K | 4 weeks |
| IP68 independent test | Yes | $4K | 3 weeks |
| IEC 61000 (EMC) | Yes | $15K | 8 weeks |
| SOC 2 Type II (cloud) | Year 2 | $70K | 12 months continuous |
| ASTM plumbing compatibility | Optional | $12K | 6 weeks |
| **Total Year 1 certification** | | **~$59K** | |

## 6. Development roadmap

### Months 0-3 (Pre-seed close → v0 dev kit)
- Finalize component selection, order dev kits
- Breadboard + first firmware, off-the-shelf LoRa devkits
- Collect first 500 hours of baseline acoustic data on test rig
- Begin CM (contract manufacturer) conversations — target 2 US + 1 Mexico + 1 Shenzhen

### Months 3-6 (v1 prototype → 10 pilot buildings)
- First injection-molded enclosures
- FCC pre-scan
- Pilot building installs (friendly buildings, no SLA)
- Cloud MVP: ingest, dashboard, manual alert routing

### Months 6-12 (v1.1 → paid pilots)
- FCC Part 15 filing + cert
- 240 Nodes across 10 commercial buildings, paying $29/sensor/month
- First version of acoustic model trained on real-world data
- Plumber app v0.5
- First certified plumber cohort: 15 plumbers in launch metro

### Year 2 (scale prep)
- v2 Node (re-spin for BOM reduction, enhanced battery)
- 2,400 Nodes live
- Insurance pilot with one lighthouse carrier
- National plumber training program launched
- SOC 2 Type II in progress

### Year 3+ (leverage)
- Volume manufacturing (50K+ Nodes/yr)
- Multi-metro rollout
- Municipal-grade Node variant (hardened, 10-year battery, above-ground water mains)

## 7. The "field install" experience

The install experience is the product. A facility manager or a maintenance tech — not a plumber — should be able to deploy 40 sensors in 45 minutes, no training. This is a non-negotiable design principle.

1. Open app → scan building QR code → sensor list appears
2. Pick a Node from the box → peel magnetic clamp liner → click onto pipe
3. Phone detects Node via BLE → prompts "Which pipe?" → user snaps photo + selects pipe type
4. Node auto-commissions to gateway → green LED
5. Repeat

Total time per sensor: ~90 seconds. Zero plumbing skill required. This is what decouples deployment from the labor shortage.

# 02 — Business Plan

## 1. Vision

Become the operating system for every pipe in every commercial building and municipal water system in North America. Own the predictive layer, the data layer, and the trusted network of certified tradespeople who actually do the work.

Within 10 years, the phrase "PipeWhisper certified" carries the same trust as "ASE certified" does in automotive repair or "NATE certified" in HVAC. Anyone can be a plumber. Only our people can be PipeWhisper plumbers.

## 2. Market

### 2.1 Total addressable market

| Segment | US TAM | Global TAM |
|--------|--------|------------|
| Commercial building plumbing maintenance | $42B | $180B |
| Residential plumbing services | $58B | $210B |
| Municipal water infrastructure | $28B | $140B |
| Insurance loss prevention (water damage) | $13B | $50B |
| Industrial process piping | $22B | $90B |
| **Total** | **$163B** | **$670B** |

### 2.2 Serviceable addressable market (Year 5 target)

We will not touch residential or industrial in the first five years. We focus on:

- **Commercial multi-tenant buildings** (offices, hotels, hospitals, campuses): 5.9M buildings in US, average 40 pipe junctions per building = 236M sensor slots.
- **Municipal water utilities**: 52,000 community systems in US, 2.2M miles of main lines.
- **Insurance underwriters**: top 25 carriers cover 80% of US commercial property.

**SAM** at year 5: ~$18B.
**SOM** at year 5: $68M ARR (0.38% of SAM — plenty of headroom).

### 2.3 Why the timing is right

1. **Hardware cost collapse.** MEMS acoustic sensors are now $2.50 in volume (2019: $18).
2. **Edge ML viability.** Transformer-based anomaly detection now runs on sub-$4 MCUs.
3. **Insurance carrier mandates.** Chubb, Zurich, FM Global all launched water-loss-prevention mandates in 2023-24. They will subsidize adoption of solutions they trust.
4. **Labor crisis.** BLS projects a shortfall of 550,000 plumbers by 2027. Efficiency tools are no longer optional.
5. **Infrastructure funding.** $55B IIJA water money is on municipal tables right now.
6. **No AI incumbents in the trade.** This is the last major labor vertical without a Rippling / Toast / ServiceTitan-style winner on the software side.

## 3. Product

See [03-product-build.md](03-product-build.md) for the full technical spec. Summary:

### The Node (sensor hardware)
- Clip-on acoustic sensor, ~65mm x 40mm x 22mm
- Contact piezo + MEMS microphone for dual-modal capture
- STM32U585 MCU running on-device TinyML anomaly detector
- LoRa + BLE radios
- 5-year battery life (3.6V Li-SOCl₂)
- IP68, -20°C to +85°C operating range
- **BOM at 10K units: $32.** **BOM at 100K units: $21.**
- Retail: $499 installed OR $0 upfront with 36-month subscription

### The Gateway
- Building-scale LoRa concentrator + 4G backup
- Raspberry Pi CM4 or equivalent
- Handles up to 400 Nodes per gateway
- BOM: $110. Retail: $399.

### The Cloud
- Time-series acoustic data ingest (Kafka → S3 + Timestream)
- Fleet management console (SaaS for facilities teams)
- Alert routing engine (the flywheel — sends jobs to certified plumbers)
- ML retraining pipeline (federated + labeled failures)

### The Certified Plumber App
- iOS / Android app for partner plumbers
- Job dispatch, acoustic diagnostic playback, customer history
- Certification training modules (built-in)
- Revenue tracking + rating system

## 4. Business model

Three revenue streams, increasingly defensible over time:

### 4.1 Hardware (wedge, not moat)
- Nodes: $499 each installed
- Gateways: $399 each
- Target gross margin: 45% at 100K unit volume
- **Strategy:** Use hardware as a low-margin entry point to lock in subscription revenue. Offer $0-upfront hardware with 36-month SaaS commit.

### 4.2 SaaS subscription (primary moat)
- **Commercial building:** $29/sensor/month (facility pays)
- **Enterprise (>500 sensors):** $18/sensor/month
- **Municipal utility:** $8/sensor/month at utility scale
- **Residential add-on (Year 3+):** $19/month flat per home
- Target gross margin: 85%

### 4.3 Plumber network referral (the hidden trade)
- 15% referral fee on every job routed to a certified plumber
- Average job value: $1,200 (emergency), $380 (scheduled)
- Projected referrals by Year 5: ~180,000/yr
- **This becomes the biggest single revenue line by Year 4.**

### 4.4 Insurance data licensing (asymmetric upside)
- Anonymized failure-rate data licensed to underwriters
- Structured as a per-policy data fee ($0.40–$2.20/policy/month)
- Targeting top 10 carriers by Year 3
- Extremely high margin (>95%)

## 5. Competitive landscape

| Competitor | Category | Weakness | Our response |
|------------|---------|----------|-------------|
| **Flo by Moen** | Residential whole-home shutoff | Consumer-only, reactive, no AI moat, no trade network | We ignore residential until Year 3 and walk past them |
| **Phyn** | Residential pressure analytics | Same — reactive, no B2B sales muscle | Same |
| **StreamLabs** | Retail leak detection | Hardware company, no AI, no services | Same |
| **Augury** | Industrial vibration AI | Not in plumbing, huge enterprise motion | We partner or acquire in Y4 |
| **ServiceTitan** | Trade SaaS (scheduling/invoicing) | No hardware, no AI, no predictive layer | We integrate + they become our distribution |
| **Regional plumbers** | The actual market | No technology, no data, no brand | They become our certified partners |

The map is empty. That is the entire point.

## 6. Go-to-market (summary — full plan in 06)

**Wedge (Year 1):** 10 commercial buildings in one metro (target: Austin or Denver). Paid pilot. Insurance-carrier co-funded.

**Expansion (Year 2):** 200 buildings + first insurance underwriting deal + first 40 certified plumbers.

**Leverage (Year 3):** National expansion through insurance carrier channel + plumber-network flywheel. Each plumber becomes a sales agent.

**Municipal (Year 4+):** Water utility contracts using IIJA funding. Long cycle, huge AOV ($800K+ per utility).

## 7. Moats

### 7.1 Data moat
Every sensor deployed improves the model for every other sensor. After 18 months of field data across 200+ buildings, the acoustic failure dataset becomes effectively unreplicable. A fast-follower would need to deploy the same hardware, wait the same time, and capture the same rare failure events. This is a 3-4 year moat minimum.

### 7.2 Network moat
The certified plumber network is not a software problem — it's a trust problem. Plumbers sign exclusive certification agreements. Their customers associate the brand with them. A fast-follower would need to re-train and re-brand thousands of tradespeople. HVAC incumbents have spent 30 years building comparable networks (NATE).

### 7.3 Insurance moat
Insurance partnerships are sold in 18-month cycles. The first carrier deal is the hardest — once one major underwriter has PipeWhisper in their underwriting model, every competitor has to re-prove the technology to every other carrier from zero.

### 7.4 Regulatory moat (emergent, Year 3+)
As insurance carriers and municipal buyers adopt, we push for voluntary standards ("PipeWhisper Certified Building", "PipeWhisper Verified Utility"). These standards become de-facto regulations over time, just as LEED did for green buildings. We write the standard. We define the category.

## 8. Organization

### 8.1 Founding team (to hire within 90 days of pre-seed close)

| Role | Comp Y1 | Equity | Profile |
|------|---------|--------|---------|
| CEO / Founder | $120K + 40% | — | You |
| CTO (HW + firmware) | $180K + 8% | Ex-Nest, Verkada, August, Ambient |
| Lead ML (DSP) | $190K + 5% | Ex-Shazam, SoundHound, Augury |
| Head of trade partnerships | $130K + 3% | Ex-plumber, trade school instructor, or UA Local union ops |
| Full-stack lead | $160K + 2% | Ex-ServiceTitan, Housecall Pro |

### 8.2 Year 2 hires
- Hardware engineer (supply chain / manufacturing)
- ML engineer #2 (data pipeline)
- Backend engineer #2
- Customer success lead
- 2x sales (enterprise)
- Finance / ops manager

### 8.3 Year 3+ build-out
- Regional network managers (one per metro)
- Municipal sales specialist
- Insurance partnership lead
- General counsel / regulatory
- VP Product

Full headcount plan in [05-cost-breakdown.md](05-cost-breakdown.md).

## 9. Risks and mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|-----------|
| False positive rate too high | Medium | High | Multi-modal sensing (piezo + MEMS + pressure), 18-month model training on pilot data |
| Hardware supply chain (semiconductor shortage) | Medium | Medium | Dual-source critical components; maintain 90-day buffer stock; design for part substitution |
| Insurance sales cycle too slow | High | Medium | Pre-sell one lighthouse carrier in parallel with seed raise; use pilot data as proof |
| Plumber network hard to build | Medium | High | Hire a head of trade partnerships from day one; start with union locals in target metro |
| Fast-follower (Honeywell, Verisure, Flo) | Medium | Medium | Speed. Data moat. Insurance lock-in. All compound if we move fast |
| Regulatory (FCC, plumbing codes) | Low | Low | Non-invasive sensor = not subject to plumbing codes. LoRa is pre-approved band |
| Customer acquisition cost explosion | Medium | High | Insurance channel + plumber channel both have near-zero CAC if we execute |

## 10. Exit paths

This is a category-defining business. Three realistic exits:

1. **Strategic acquisition by an HVAC/building-systems giant** (Honeywell, Johnson Controls, Schneider Electric) — 6–10x ARR in Years 4-6.
2. **Strategic acquisition by an insurance carrier or ServiceTitan-style SaaS** — 10–15x ARR, driven by data and network effects.
3. **IPO path.** If we reach $100M+ ARR with 60%+ growth, the public market is open (comps: Samsara, PagerDuty, Procore).

Floor case (Year 5, $68M ARR × 8x): **$544M**.
Base case (Year 5, $68M ARR × 12x): **$816M**.
Bull case (Year 7, $220M ARR × 10x): **$2.2B**.

We build for the base case and keep the option on the bull case.

# 05 — Cost Breakdown

Every dollar we spend, accounted for. This is the internal view — the number behind the number.

## 1. Cost of Goods Sold (COGS)

### 1.1 Node unit economics (sensor)

| Line | @ 1K units | @ 10K units | @ 100K units | @ 500K units |
|------|-----------|-------------|--------------|--------------|
| Raw BOM | $42.60 | $32.10 | $21.40 | $17.80 |
| Contract mfg labor + test | $6.20 | $3.50 | $1.80 | $1.20 |
| Programming + provisioning | $2.10 | $1.20 | $0.60 | $0.35 |
| Packaging | $1.40 | $0.80 | $0.40 | $0.25 |
| Inbound freight + duty | $3.00 | $1.50 | $0.80 | $0.50 |
| Warehousing + fulfillment | $2.20 | $1.10 | $0.70 | $0.45 |
| Reverse logistics reserve (3%) | $1.50 | $1.20 | $0.78 | $0.60 |
| **Fully-loaded cost per Node** | **$59.00** | **$41.40** | **$26.48** | **$21.15** |

Retail: $499. Or $0 with 36-month $29/mo SaaS commit ($1,044 contracted value on the SaaS line, hardware absorbed into the CAC/COGS split).

### 1.2 Gateway unit economics

| Line | @ 1K | @ 10K |
|------|------|-------|
| Raw BOM | $123.70 | $100.30 |
| Assembly + test | $14.00 | $8.00 |
| Packaging + freight | $6.00 | $3.00 |
| **Fully-loaded** | **$143.70** | **$111.30** |

Retail: $399. Margin @ 10K: 72%.

### 1.3 Cloud COGS per sensor per month (Year 3 steady state)

| Line | Cost |
|------|------|
| Ingest (MSK) | $0.08 |
| Hot storage (Timestream) | $0.11 |
| Cold storage (S3 parquet) | $0.04 |
| Compute — inference (Lambda + SageMaker) | $0.22 |
| API serving + auth | $0.06 |
| Monitoring + logging | $0.03 |
| 3rd party APIs (SMS, Twilio, maps) | $0.09 |
| **Total cloud COGS / sensor / month** | **$0.63** |

At 140K sensors (Year 5), total cloud COGS = **~$1.05M/year**.
SaaS gross margin = ($29 − $0.63) / $29 = **97.8%** at the cloud line alone.
Blended SaaS gross margin after customer success, payment processing, and overhead: **~85%**.

## 2. Headcount plan

### 2.1 Year 1 (8 FTE, plus founder)

| Role | Salary | Equity | Loaded cost* |
|------|--------|--------|-------------|
| Founder / CEO | $120,000 | 40% | $156,000 |
| CTO (HW + firmware) | $180,000 | 8% | $234,000 |
| Lead ML engineer | $190,000 | 5% | $247,000 |
| Full-stack lead | $160,000 | 2.5% | $208,000 |
| Head of trade partnerships | $130,000 | 3% | $169,000 |
| Firmware engineer | $150,000 | 1.5% | $195,000 |
| ML engineer #2 | $160,000 | 1% | $208,000 |
| Hardware engineer | $155,000 | 1.5% | $201,500 |
| Ops / field | $95,000 | 0.5% | $123,500 |
| **Subtotal** | $1,340,000 | 63% | **$1,742,000** |

*Loaded cost = salary × 1.30 (payroll tax, benefits, equipment, workspace).

### 2.2 Year 2 (+7 FTE → 16 total)

New hires: VP Sales, Account Executive (x2), Customer Success lead, Backend engineer, ML engineer #3, Hardware/supply chain lead.

Year 2 total headcount loaded cost: **~$3.6M**

### 2.3 Year 3 (+18 FTE → 34 total)

Regional sales hires (one per target metro × 4), inside sales team (x5), certified-plumber network managers (x3), Finance/Ops manager, GC, additional engineers (x4), VP Engineering.

Year 3 total headcount loaded cost: **~$8.1M**

### 2.4 Year 4 (+28 FTE → 62 total)

International expansion prep, municipal sales team, insurance partnership lead, product managers, security lead (SOC 2 → FedRAMP), regional ops managers.

Year 4 total headcount loaded cost: **~$14.8M**

### 2.5 Year 5 (+48 FTE → 110 total)

Scale across all functions. VP roles for Product, Marketing, Finance, People.

Year 5 total headcount loaded cost: **~$26.2M**

## 3. Year 1 detailed budget ($1.35M OpEx)

| Category | Budget | % | Notes |
|----------|--------|---|-------|
| **People** | $720K | 53% | 6 FTE average over the year (ramped hiring) |
| **Hardware R&D** | $180K | 13% | Dev kits, CM NRE, test equipment, certification lab |
| **Certifications** | $60K | 4% | FCC, UL, IP68, EMC |
| **Pilot Node inventory** | $60K | 4% | 500 units @ ~$120 all-in first-run cost |
| **Cloud infra** | $18K | 1% | AWS + Vercel at pilot scale |
| **Legal & IP** | $50K | 4% | Patent filings (3), corp formation, investor docs, insurance partnership diligence |
| **Sales & marketing** | $120K | 9% | Brand, website, conference booth at AWWA + MCAA, one lighthouse case study |
| **Tooling & software** | $40K | 3% | GitHub Enterprise, Figma, Linear, observability, SaaS stack |
| **Office & workspace** | $36K | 3% | Coworking or small warehouse with hardware lab corner |
| **Travel** | $30K | 2% | Customer sites, CM visits, investor meetings |
| **Contingency** | $36K | 3% | 3% reserve |
| **Total** | **$1,350K** | **100%** | |

## 4. Year 1 CapEx ($140K)

| Item | Cost |
|------|------|
| Test equipment (oscilloscope, logic analyzer, acoustic isolation chamber) | $42K |
| Pipe test rig (multiple materials, pressure-cycled) | $28K |
| Injection mold tooling (Node v1) | $38K |
| Programming / provisioning fixture | $12K |
| Lab buildout (benches, ESD stations, storage) | $14K |
| Dev workstations + laptops | $6K |
| **Total Y1 CapEx** | **$140K** |

## 5. Fundraising use of funds

### 5.1 Pre-seed — $750K

| Use | Amount | % |
|-----|--------|---|
| Team (4 hires, 6 mo runway each) | $380K | 51% |
| Hardware R&D + pilot manufacturing | $180K | 24% |
| Certifications (FCC, UL, IP68) | $60K | 8% |
| Cloud + tools | $30K | 4% |
| Legal + IP (3 patents filed) | $50K | 7% |
| Pilot deployments (sensors + install) | $40K | 5% |
| Buffer | $10K | 1% |
| **Total** | **$750K** | |

**Milestones unlocked:** 10 paying pilots signed, false-positive rate <8% validated, FCC cert complete, Node v1 in limited production, one insurance underwriter in diligence.

### 5.2 Seed — $4.0M

| Use | Amount | % |
|-----|--------|---|
| Team expansion (8 → 16 FTE) | $1,900K | 48% |
| Volume manufacturing ramp (5K Node + 200 Gateway run) | $700K | 18% |
| Sales & marketing (brand, first AE hires) | $550K | 14% |
| Cloud infrastructure scale-up | $150K | 4% |
| Additional certifications (EMC, SOC 2 Type I start) | $180K | 5% |
| Patent portfolio expansion | $120K | 3% |
| Insurance carrier pilot program (co-funded) | $200K | 5% |
| Buffer / working capital | $200K | 5% |
| **Total** | **$4,000K** | |

**Milestones unlocked:** 200 buildings live, 40 certified plumbers, lighthouse insurance partnership signed, $2M ARR run rate.

### 5.3 Series A — $18M

Distribution approximately:
- People: 40% (hire to 50 FTE)
- S&M: 25% (4 metros launched)
- Manufacturing: 15% (50K Node production run)
- R&D (v2 hardware + municipal variant): 12%
- Cloud / infra / security: 5%
- Reserve: 3%

### 5.4 Series B — $60M

- People: 30%
- S&M + international prep: 30%
- Manufacturing (scale to 200K+ units) + working capital: 25%
- Municipal sales + regulatory: 10%
- Reserve + M&A: 5%

## 6. Break-even analysis

**Contribution margin per building / month** (Year 3 baseline):
- Revenue: $812 ($29 × 28 sensors)
- Variable cost: $122 (cloud, payment processing, customer success alloc)
- **Contribution margin: $690/mo**

**Fixed cost base** (Year 3): $10.6M OpEx + $2.4M COGS fixed = $13M/yr
**Break-even building count:** $13M ÷ ($690 × 12) = **1,570 buildings**

We hit 1,570 buildings in Q2 Year 4 — matching the EBITDA positive inflection in the financial model.

## 7. What we will NOT spend money on

- Residential TV / radio advertising (wrong channel for B2B trade)
- Fancy office (until Series B, we run lean out of a warehouse + lab)
- Consultants for anything engineering/hardware can do in-house
- Rebrand before we have 100 customers
- International expansion before North American dominance
- Commissioning our own contract manufacturing facility (use CMs until Year 4 minimum)
- Replacing plumbers — this is a partnership business, not a disintermediation play

These anti-spending rules are as important as the spending plan. Every dollar not spent on the wrong thing is a dollar of runway.

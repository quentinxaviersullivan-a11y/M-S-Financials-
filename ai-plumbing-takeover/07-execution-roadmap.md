# 07 — 52-Week Execution Roadmap

From pre-seed close to Seed raise. Week-by-week. This is what you do the day after the money hits the bank.

Rules:
- Every week has a deliverable. Not "work on X" — a thing that exists by Friday.
- If a week's deliverable slips, the next week's plan changes. Nothing accumulates.
- Every 4 weeks, re-baseline against the 12-month plan. Cut scope ruthlessly.

---

## PHASE 1 — FOUND (Weeks 1-8)

**Goal:** Team, legal, first hardware bench, first 3 pilot LOIs.

### Week 1 — Setup
- [ ] Delaware C-corp formed (Stripe Atlas or Clerky)
- [ ] Founders' stock issued, 83(b) filed
- [ ] Brex + Mercury accounts opened
- [ ] SAFE or Priced Round docs drafted
- [ ] Pre-seed money wired
- [ ] Founder signs lease on Austin coworking + hardware lab corner

### Week 2 — Team (round 1)
- [ ] CTO candidate outreach: 30 intro emails sent (Nest / Verkada / Ambient / August alumni)
- [ ] ML lead outreach: 20 intro emails (Augury / Shazam / SoundHound alumni, or DSP PhDs)
- [ ] Published job descriptions on Wellfound, Hacker News "who's hiring", LinkedIn
- [ ] First 5 candidate screens booked

### Week 3 — Pilot outreach (round 1)
- [ ] Target list built: 30 Austin commercial property operators (Cushman & Wakefield brokers as backchannel)
- [ ] First 10 cold emails sent, founder-signed
- [ ] 3 intro meetings booked for weeks 4-5

### Week 4 — Hardware bench
- [ ] Dev kits ordered: STM32U585 Nucleo, Knowles SPH0645 eval, Semtech SX1262 dev, Tadiran battery samples
- [ ] Lab buildout: bench, oscilloscope, ESD mats, pipe test rig (Lowe's parts — copper, PVC, PEX — $800 of fittings)
- [ ] Legal: NDA template + MSA template drafted

### Week 5 — First hires
- [ ] CTO offer extended (target start: week 8)
- [ ] ML lead offer extended (target start: week 9)
- [ ] Head of trade partnerships candidate screens (union locals, trade school instructors)

### Week 6 — Pilot outreach (round 2)
- [ ] First 3 pilot meetings held — pitch + free pilot offer
- [ ] Outreach batch 2: 20 more operators
- [ ] First 2 LOIs signed (non-binding, free pilot, 12-month SaaS conversion option)

### Week 7 — First code
- [ ] Founder writes the dead-simple v0 firmware: capture 10s audio window, send over BLE to laptop
- [ ] First pipe acoustic signature captured on lab rig
- [ ] Slide deck updated with "we have raw hardware data" — used for insurance carrier outreach

### Week 8 — Team onboarding
- [ ] CTO starts
- [ ] First engineering standup
- [ ] 3 pilot LOIs locked in
- [ ] **MILESTONE:** Team of 3, hardware captures first real acoustic data, 3 pilots committed

---

## PHASE 2 — BUILD (Weeks 9-20)

**Goal:** v1 Node hardware, first 10 pilots signed, first version of the acoustic model.

### Week 9 — ML lead starts
- [ ] ML lead sets up data pipeline: raw audio → S3 → labeled dataset
- [ ] First acoustic baseline dataset collected (40 hours of healthy pipe audio)
- [ ] Model architecture decided: 1D-CNN + transformer head (TFLM compatible)

### Week 10-11 — v0 hardware prototype
- [ ] First breadboard with MCU + mic + piezo + LoRa + battery
- [ ] Sensor housed in a 3D-printed shell (Formlabs or local print shop)
- [ ] First installs on the lab pipe rig — 5 breadboard sensors
- [ ] Failure simulation: induced leaks, pressure spikes, water hammer — capture labeled data

### Week 12 — Head of trade partnerships starts
- [ ] UA Local 286 (Austin) introduction meeting booked
- [ ] ACC (Austin Community College) plumbing program director meeting booked
- [ ] First 3 friendly plumbers identified for ground-truth labeling

### Week 13-14 — Pilot contracts
- [ ] Pilot MSA + Pilot SOW finalized (see `templates/pilot-agreement.md`)
- [ ] 3 pilot MSAs signed
- [ ] Additional 4 LOIs in negotiation

### Week 15-16 — v1 schematic + PCB
- [ ] Full PCB schematic complete
- [ ] PCB layout → first rev sent to JLCPCB or Sierra Circuits
- [ ] Contract manufacturer conversations: 3 shortlisted (2 US, 1 Mexico)

### Week 17 — First model v0.1
- [ ] Model trained on 120 hours of lab data, 4 failure classes
- [ ] First false positive / true positive metrics on held-out test set
- [ ] Model quantized to int8, deployed on STM32U5 eval board
- [ ] On-device inference working, ~180KB flash

### Week 18-19 — Pilot signings continued
- [ ] 7 of 10 pilot buildings signed
- [ ] First pilot install scheduled for week 22
- [ ] First 5 friendly plumbers recruited to labeling network

### Week 20 — Board update + interim milestone
- [ ] Internal board update prepared
- [ ] 10 pilot LOIs in hand (7 signed, 3 in paper)
- [ ] v1 PCB returned from fab, populated on bench
- [ ] **MILESTONE:** v1 Node working on bench, 10 pilots lined up, model trained on lab data

---

## PHASE 3 — DEPLOY (Weeks 21-32)

**Goal:** All 10 pilots live. Real failure data coming in. FCC certification in progress.

### Week 21 — First pilot install
- [ ] First building installed: 20 Nodes + 1 Gateway
- [ ] Self-install UX tested with facility manager
- [ ] First real-world acoustic data in S3 by Friday

### Week 22-24 — Install wave 1
- [ ] 4 more buildings installed
- [ ] First dashboard UI shipped (Next.js, minimal — just "here are your sensors, here are the alerts")
- [ ] First alert sent (even if it's low-confidence) — proves the loop works
- [ ] First plumber dispatched via manual routing

### Week 25 — FCC pre-scan
- [ ] Sent to certified FCC pre-scan lab
- [ ] EMC issues identified, PCB rev 1.1 initiated
- [ ] Certification timeline locked in: 10 weeks from formal submission

### Week 26-28 — Install wave 2
- [ ] Remaining 5 pilot buildings installed
- [ ] All 10 pilots live, ~240 sensors active
- [ ] First full week of clean telemetry across all sites
- [ ] Data pipeline processing 24/7

### Week 29 — Model v1.0
- [ ] Retrained on pilot + lab data
- [ ] Precision at 72-hr horizon: target 78%, acceptable 72%
- [ ] First real prevented failure event documented (target — may not happen yet)

### Week 30-31 — Insurance carrier outreach
- [ ] 5 insurance carriers cold-pitched (Chubb, Travelers, FM Global, Zurich, Hartford)
- [ ] First exploratory meeting booked
- [ ] Insurance co-funded pilot proposal drafted

### Week 32 — FCC filing
- [ ] Formal FCC Part 15 submission
- [ ] PCB rev 1.1 in production
- [ ] **MILESTONE:** 10 pilots live, v1 model running, 240 sensors streaming, 1 insurance meeting booked

---

## PHASE 4 — LEARN (Weeks 33-44)

**Goal:** Validate the 72-hour prediction. Prove false positive rate under 15%. Build case study material.

### Week 33 — Continuous learning
- [ ] Weekly model retraining cadence locked in
- [ ] Labeling ops: every alert classified as TP/FP by friendly plumber network within 48 hours
- [ ] First monthly pilot customer check-ins (NPS, satisfaction, issues)

### Week 34-36 — First real failures captured
- [ ] At least 2 real catastrophic failures captured in dataset (expected based on base rate of 20-30 pipe incidents per 10 buildings per year)
- [ ] First "we predicted it" case study draft
- [ ] Precision at 72hr target: 82%+

### Week 37 — Model v1.5 + push
- [ ] OTA push to all fielded Nodes (first OTA in production — critical milestone)
- [ ] Model quality iteration report

### Week 38-39 — Insurance pilot discussion
- [ ] Deep-dive meeting with lead insurance carrier
- [ ] Co-funded pilot proposal accepted (or rejected — if rejected, pivot to next carrier)
- [ ] Case study #1 published externally

### Week 40 — Plumber network formalized
- [ ] First "PipeWhisper Certified Plumber" program launched
- [ ] 15 Austin plumbers enrolled
- [ ] 2-day training curriculum v1.0 delivered
- [ ] Plumber app v0.5 shipped (iOS)

### Week 41-43 — Seed fundraise prep
- [ ] Seed deck drafted
- [ ] Data room assembled (see `templates/data-room-index.md`)
- [ ] Target Seed investor list built (40 funds)
- [ ] Warm intros lined up

### Week 44 — Seed outreach begins
- [ ] First 10 Seed intro meetings booked
- [ ] **MILESTONE:** 10 pilots live, 15 certified plumbers, insurance partnership in negotiation, Seed raise active

---

## PHASE 5 — RAISE (Weeks 45-52)

**Goal:** Close $4M Seed. Leave pre-seed money in the bank.

### Week 45-48 — Seed roadshow
- [ ] 25-30 investor meetings
- [ ] Full pitch deck iterated weekly
- [ ] Q&A refined
- [ ] Technical due diligence calls (CTO + ML lead lead these)

### Week 49 — Term sheets
- [ ] First term sheet arrives (target)
- [ ] Compare terms across 2-3 offers
- [ ] Lead investor selected

### Week 50 — Close process
- [ ] Legal close (NVCA forms — Series Seed)
- [ ] Board composition agreed
- [ ] Allocation across participants finalized

### Week 51 — Wire + announce
- [ ] Money wired
- [ ] Internal team announcement
- [ ] Public announcement (TechCrunch + trade press)

### Week 52 — Year 1 retrospective + Year 2 plan
- [ ] Year 1 metrics baseline captured (KPIs, lessons learned)
- [ ] Year 2 roadmap drafted and signed off by board
- [ ] **FINAL MILESTONE:** $4M Seed closed, 16 FTE hiring plan started, 200-building Year 2 target set

---

## Rolling metrics dashboard

Track these every Friday, on a single whiteboard or Linear dashboard. No exceptions.

| Metric | Y1 target (EOY) |
|--------|-----------------|
| Pilots signed | 10 |
| Sensors live | 240 |
| Certified plumbers | 15 |
| Cumulative acoustic data | 10,000 hours |
| Model precision (72hr) | 82%+ |
| False positive rate | <15% |
| Insurance meetings held | 12 |
| Team size | 8 FTE |
| Cash runway remaining | >6 months at any point |

## What breaks this plan

1. **CTO hire takes longer than 4 weeks.** Mitigation: Founder can write firmware for 8 more weeks if needed; ML lead can be hired first.
2. **FCC certification delayed.** Mitigation: Pilot buildings can run under experimental authorization while formal cert processes in parallel.
3. **First pilot won't sign a paid contract.** Mitigation: Offer free-for-data pilots for the first 3. Drop to pure research agreement.
4. **Real failures don't happen in pilot buildings during Year 1.** Mitigation: Supplement with lab-induced failures + partnership with a municipal water utility for historical data access.
5. **Seed market freezes.** Mitigation: Pre-seed money must last 18 months, not 12. Headcount plan has a low-burn fallback (stay at 6 FTE, extend runway to month 20).

## The discipline

The roadmap is a contract with yourself. Every Friday, mark each week's deliverable as done/not-done. If two consecutive weeks miss, call an emergency re-plan session with the team. Do not let slippage accumulate silently — that's how startups die.

The goal is not to follow the plan perfectly. The goal is to always know where you are relative to it.

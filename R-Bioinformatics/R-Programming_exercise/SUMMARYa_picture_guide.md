### Cancer progression models or monotonic accumulation models
Monotonic accumulation models try to infer the dependencies that give rise to the patterns we observe in the data. 

The key idea is that many phenomena involve the irreversible accumulation (or loss) of certain features or events, and that different events are not independent but can affect the acquisition (or loss) of other events.

Understanding the sequence of events can help identify diagnostic targets or stratify patients for differential treatments.

Types:
- **Linear accumulation** (deterministeic) models: asume that one event is always directly required for the accumulation of another event.
- **Richer deterministic** models: allow more complex dependencies (e.g. an event can depend on the occurrence of one among several possible previous events).
- **Stochastic dependencies** models: assume that events have inhibiting or enhancing effects on the probability of acquisition of other events.

We are interested in how some features or events that characterise a process accumulate (or are lost) irreversibly. Examples: 
- how mutations in driver genes accumulate during cancer progression 
- or how symptoms (fever, vomiting, anemia, . . . ) accumulate during severe malaria


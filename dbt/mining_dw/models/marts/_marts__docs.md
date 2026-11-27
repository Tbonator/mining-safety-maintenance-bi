{% docs injury_rate %}
Injuries per 200,000 hours worked, the US standard: 100 full-time workers
× 40 hours × 50 weeks. Always sum injuries and sum hours first, then divide.
Never average rates across mines or quarters.
{% enddocs %}

{% docs is_injury %}
True for an injury to an employee: fatal, permanent disability, days away
from work, restricted duty, or medical treatment only. False for accidents
with no injury, occupational illnesses, natural causes, non-employees and
first aid. Based on MSHA's degree of injury.
{% enddocs %}

{% docs is_contractor_injury %}
True when the injured person worked for a contractor rather than the mine
operator. MSHA publishes contractor hours nationally only, so per-mine
rates must exclude these.
{% enddocs %}

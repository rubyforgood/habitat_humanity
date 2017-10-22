FactoryGirl.define do
  factory :shift_event do
    shift
    occurred_at {
      tz_day = day.in_time_zone
      Faker::Time
        .between(tz_day.beginning_of_day, tz_day.end_of_day)
        .in_time_zone
    }
    action      { ShiftEvent::ACTIONS.keys.sample }
    signature   { 'data:image/png;base64,
iVBORw0KGgoAAAANSUhEUgAAASwAAABDCAMAAAARdsh8AAADAFBMVEUAAAABAQECAgIDAwMEBAQF
BQUGBgYHBwcICAgJCQkKCgoLCwsMDAwNDQ0ODg4PDw8QEBARERESEhITExMUFBQVFRUWFhYXFxcY
GBgZGRkaGhobGxscHBwdHR0eHh4fHx8gICAhISEiIiIjIyMkJCQlJSUmJiYnJycoKCgpKSkqKior
KyssLCwtLS0uLi4vLy8wMDAxMTEyMjIzMzM0NDQ1NTU2NjY3Nzc4ODg5OTk6Ojo7Ozs8PDw9PT0+
Pj4/Pz9AQEBBQUFCQkJDQ0NERERFRUVGRkZHR0dISEhJSUlKSkpLS0tMTExNTU1OTk5PT09QUFBR
UVFSUlJTU1NUVFRVVVVWVlZXV1dYWFhZWVlaWlpbW1tcXFxdXV1eXl5fX19gYGBhYWFiYmJjY2Nk
ZGRlZWVmZmZnZ2doaGhpaWlqampra2tsbGxtbW1ubm5vb29wcHBxcXFycnJzc3N0dHR1dXV2dnZ3
d3d4eHh5eXl6enp7e3t8fHx9fX1+fn5/f3+AgICBgYGCgoKDg4OEhISFhYWGhoaHh4eIiIiJiYmK
ioqLi4uMjIyNjY2Ojo6Pj4+QkJCRkZGSkpKTk5OUlJSVlZWWlpaXl5eYmJiZmZmampqbm5ucnJyd
nZ2enp6fn5+goKChoaGioqKjo6OkpKSlpaWmpqanp6eoqKipqamqqqqrq6usrKytra2urq6vr6+w
sLCxsbGysrKzs7O0tLS1tbW2tra3t7e4uLi5ubm6urq7u7u8vLy9vb2+vr6/v7/AwMDBwcHCwsLD
w8PExMTFxcXGxsbHx8fIyMjJycnKysrLy8vMzMzNzc3Ozs7Pz8/Q0NDR0dHS0tLT09PU1NTV1dXW
1tbX19fY2NjZ2dna2trb29vc3Nzd3d3e3t7f39/g4ODh4eHi4uLj4+Pk5OTl5eXm5ubn5+fo6Ojp
6enq6urr6+vs7Ozt7e3u7u7v7+/w8PDx8fHy8vLz8/P09PT19fX29vb39/f4+Pj5+fn6+vr7+/v8
/Pz9/f3+/v7////isF19AAAACXBIWXMAAAxOAAAMTgF/d4wjAAAgAElEQVR4nO18CThV39/vPuc4
xzzPQyFT5qFCyC+FCo0UoUkRzSGFSvOoUVEpSpSoaKTSgAiZZU5knmdnPsdda+9janjf//vc+7z3
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
/wvZSv1j6AvUgAAAAABJRU5ErkJggg==' }
  end
end

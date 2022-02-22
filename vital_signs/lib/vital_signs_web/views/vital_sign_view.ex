defmodule VitalSignsWeb.VitalSignView do
  use VitalSignsWeb, :view

  alias VitalSignsWeb.VitalSignView

  def render("vital_signs.json", %{vital_signs: vital_signs}) do
    %{vital_signs: render_many(vital_signs, VitalSignView, "vital_sign.json")}
  end

  def render("vital_sign.json", %{vital_sign: vital_sign}) do
    %{
      id: vital_sign.id,
      name: vital_sign.name
    }
  end
end

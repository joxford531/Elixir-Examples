defmodule Control do
  def double(x) when is_number(x), do: 2 * x
  def double(x) when is_binary(x), do: x <> x

  def fact(0), do: 1
  def fact(n), do: n * fact(n - 1)

  def sum([]), do: 0
  def sum([h | t]), do: h + sum(t)

  def max_cond(a, b) do
    cond do
      a >= b -> a
      true -> b
    end
  end

  def max_case(a, b) do
    case a >= b do
      true -> a
      false -> b
    end
  end  

end

defmodule Login do
  defp extract_login(%{"login" => login}), do: {:ok, login}
  defp extract_login(_), do: {:error, "login missing"}

  defp extract_email(%{"email" => email}), do: {:ok, email}
  defp extract_email(_), do: {:error, "email missing"}

  defp extract_password(%{"password" => password}), do: {:ok, password}
  defp extract_password(_), do: {:error, "password missing"}

  def extract_user(user) do
    with {:ok, login} <- extract_login(user),
      {:ok, email} <- extract_email(user),
      {:ok, password} <- extract_password(user) do
        {:ok, %{login: login, email: email, password: password}}
    end
  end

  def extract_case_user(user) do
    case Enum.filter(["login", "email", "password"],
      &(not Map.has_key?(user, &1))
    ) do
      [] -> {:ok, %{ login: user["login"], email: user["email"], password: user["password"] }}
      missing_fields -> {:error, "Missing fields: #{Enum.join(missing_fields, ", ")}" }
    end
  end

end

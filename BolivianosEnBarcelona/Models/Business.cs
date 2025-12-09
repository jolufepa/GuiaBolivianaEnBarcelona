using System.ComponentModel.DataAnnotations;
using System.Text;
using System.Globalization;
using System.Text.Json.Serialization; // Necesario para [JsonIgnore]

namespace BolivianosEnBarcelona.Models
{
    public class Business
    {
        public string Id { get; set; } = Guid.NewGuid().ToString();

        [Required(ErrorMessage = "El nombre es obligatorio")]
        public string Name { get; set; } = string.Empty;

        public string Description { get; set; } = string.Empty;
        public string Category { get; set; } = "General";
        public string Address { get; set; } = string.Empty;
        public string PhoneNumber { get; set; } = string.Empty;

        // Coordenadas (Ya las usamos para el "Cerca de mí")
        public double Latitude { get; set; }
        public double Longitude { get; set; }

        public string WhatsAppLink => string.IsNullOrEmpty(PhoneNumber) ? "#" : $"https://wa.me/{PhoneNumber.Replace(" ", "").Replace("+", "")}";
        public string ImageUrl { get; set; } = "images/default.png";
        public bool IsPromoted { get; set; } = false;

        // --- OPTIMIZACIÓN DE RENDIMIENTO ---

        // Estas propiedades guardarán el texto en minúsculas y sin tildes.
        // Usamos [JsonIgnore] para que NO se intenten leer/guardar en el archivo json, solo viven en la memoria.
        [JsonIgnore]
        public string NormalizedName { get; private set; } = string.Empty;

        [JsonIgnore]
        public string NormalizedDescription { get; private set; } = string.Empty;

        [JsonIgnore]
        public string NormalizedCategory { get; private set; } = string.Empty;

        // Método que llamaremos UNA sola vez al iniciar la app
        public void PrepararBusqueda()
        {
            NormalizedName = QuitarAcentos(Name).ToLower();
            NormalizedDescription = QuitarAcentos(Description).ToLower();
            NormalizedCategory = QuitarAcentos(Category).ToLower();
        }

        // Movemos la lógica de quitar acentos aquí para que sea reutilizable
        private static string QuitarAcentos(string texto)
        {
            if (string.IsNullOrWhiteSpace(texto)) return string.Empty;
            var normalizedString = texto.Normalize(NormalizationForm.FormD);
            var stringBuilder = new StringBuilder();

            foreach (var c in normalizedString)
            {
                if (CharUnicodeInfo.GetUnicodeCategory(c) != UnicodeCategory.NonSpacingMark)
                {
                    stringBuilder.Append(c);
                }
            }
            return stringBuilder.ToString().Normalize(NormalizationForm.FormC);
        }
    }
}
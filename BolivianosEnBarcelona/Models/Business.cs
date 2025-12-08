using System.ComponentModel.DataAnnotations;

namespace BolivianosEnBarcelona.Models
{
    public class Business
    {
        public string Id { get; set; } = Guid.NewGuid().ToString();

        [Required(ErrorMessage = "El nombre es obligatorio")]
        public string Name { get; set; } = string.Empty;

        public string Description { get; set; } = string.Empty;

        // Categoría: Restaurante, Legal, Envíos, etc.
        public string Category { get; set; } = "General";

        public string Address { get; set; } = string.Empty;
        public string PhoneNumber { get; set; } = string.Empty;

        // WhatsApp directo (clave para ventas)
        public string WhatsAppLink => string.IsNullOrEmpty(PhoneNumber) ? "#" : $"https://wa.me/{PhoneNumber.Replace(" ", "").Replace("+", "")}";

        public string ImageUrl { get; set; } = "images/default.png"; // Foto por defecto

        public bool IsPromoted { get; set; } = false; // ¿Paga por salir primero?
    }
}
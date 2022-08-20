namespace guitar_backend.ActionModels
{
    public class SearchModel
    {
        public string SearchStr { get; set; } = string.Empty;
        public string? Color { get; set; }
        public string? Company { get; set; }
        public string? Category { get; set; }
    }
}

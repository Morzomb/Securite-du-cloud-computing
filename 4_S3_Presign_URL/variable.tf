variable "bucket_name" {
  description = "Nom du compartiment S3"
  default     = "esgigroupe004"
}

variable "object_key" {
  description = "Clé de l'objet S3"
  default     = "tqt2.JPG"
}

variable "local_file_path" {
  description = "Chemin local du fichier à téléverser"
  default     = "C:/Users/anthony/Downloads/IMG_8569.JPG"
}

variable "mime_type" {
  description = "Type MIME du fichier"
  default     = "image/jpeg"
}

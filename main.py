from detector_aedes.detector_aedes import AedesDetector
from detector_aedes.image_connectors import FolderConnector
from detector_aedes.connectors import FileOutputConnector  # ← esta es la que necesitás

# Asumo que el detector espera que el input tenga get_image_ids() y get_image()
# FolderConnector implementa eso

ic = FolderConnector('/data/input')

# Ahora buscamos qué usar como "output"
# Si no tenés FileOutputConnector, probablemente se use algún método tipo `.save_results(path)`
# o se pasa una ruta como argumento

# Caso 1 – Si AedesDetector permite pasar solo el path:
fc = FileOutputConnector('/data/output/output.csv')

# Caso 2 – Si encontrás alguna clase para manejar CSV output, usala acá

ad = AedesDetector(input_connector=ic, output_connector=fc)
ad.process(show_results=False)